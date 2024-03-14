import json
import boto3
import base64
import os
from botocore.exceptions import BotoCoreError, ClientError

s3 = boto3.client('s3')
# Use environment variable for the S3 bucket name
BUCKET_NAME = os.environ.get('BUCKET_NAME')

def lambda_handler(event, context):
    try:
        # Parse the input data
        body = json.loads(event.get('body', '{}'))
        phone_number = body.get('phone_number')
        pan_image = body.get('pan_image')
        aadhar_image = body.get('aadhar_image')
        face_image = body.get('face_image')
        
        # Validate input more thoroughly
        if not all([phone_number, pan_image, aadhar_image, face_image]):
            return response(400, 'Missing or incomplete data in request')
        
        if not is_base64(pan_image) or not is_base64(aadhar_image) or not is_base64(face_image):
            return response(400, 'One or more images are not properly encoded in base64')

        # Upload the images to S3
        upload_image(pan_image, f'pan/{phone_number}/image.jpeg')
        upload_image(aadhar_image, f'aadhar/{phone_number}/image.jpeg')
        upload_image(face_image, f'faces/{phone_number}/image.jpeg')
        
        return response(200, 'Images uploaded successfully')
    except ValueError as ve:
        print(ve)
        return response(400, 'Invalid JSON format in request body')
    except Exception as e:
        print(e)
        return response(500, 'Internal error processing the request')

def upload_image(image_base64, object_name):
    try:
        image_data = base64.b64decode(image_base64)
        s3.put_object(Bucket=BUCKET_NAME, Key=object_name, Body=image_data, ContentType='image/jpeg')
    except (BotoCoreError, ClientError) as aws_error:
        print(f"AWS Error: {aws_error}")
        raise Exception('Failed to upload image to S3') from aws_error
    except ValueError:
        raise Exception('Image data is not in base64 format')

def is_base64(sb):
    try:
        if not sb or isinstance(sb, str) == False:
            return False
        base64.b64decode(sb, validate=True)
        return True
    except ValueError:
        return False

def response(status_code, body):
    return {
        'statusCode': status_code,
        'body': json.dumps(body)
    }
