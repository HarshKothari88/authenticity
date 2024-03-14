import boto3
import json
import os

def lambda_handler(event, context):
    errors = []
    mismatches = []

    # Parse the event body to get the phone number
    try:
        # If the Lambda function is invoked by API Gateway with the Lambda proxy integration,
        # event['body'] is a JSON string
        body = json.loads(event['body'])
    except json.JSONDecodeError:
        return {
            'statusCode': 400,
            'body': json.dumps('The body of the request is not valid JSON.')
        }

    # Extract the phone number identifier from the event body
    phone_number = body.get('phone_number')
    if not phone_number:
        return {
            'statusCode': 400,
            'body': json.dumps('Missing identifier in the request.')
        }

    # Replace with your S3 bucket name environment variable
    BUCKET_NAME = os.environ.get('BUCKET_NAME', 'default-bucket-name')
  
    # Construct the S3 key paths based on the phone number identifier
    pan_key = f'pan/{phone_number}/image.jpeg'
    aadhar_key = f'aadhar/{phone_number}/image.jpeg'
    face_key = f'faces/{phone_number}/image.jpeg'

    # Initialize the boto3 Rekognition client
    rekognition_client = boto3.client('rekognition')

    # Define the compare_faces function
    def compare_faces(source_image_key, target_image_key):
        try:
            response = rekognition_client.compare_faces(
                SourceImage={'S3Object': {'Bucket': bucket_name, 'Name': source_image_key}},
                TargetImage={'S3Object': {'Bucket': bucket_name, 'Name': target_image_key}},
            )
            if response['FaceMatches']:
                return True, None
            else:
                return False, f"No face matches found between {source_image_key} and {target_image_key}."
        except Exception as e:
            return False, f"Error: {str(e)}"

    # Perform the comparisons
    pan_faces_match, pan_error = compare_faces(face_key, pan_key)
    aadhar_faces_match, aadhar_error = compare_faces(face_key, aadhar_key)

    # Collect errors and mismatches
    if not pan_faces_match:
        mismatches.append('pan')
        errors.append(pan_error)
    if not aadhar_faces_match:
        mismatches.append('aadhar')
        errors.append(aadhar_error)

    # Determine the result
    if pan_faces_match and aadhar_faces_match:
        result = "All faces match: True"
        statusCode = 200
    else:
        result = f"All faces match: False. Mismatches: {', '.join(mismatches)}."

    # Return the result along with any error messages
    return {
        'statusCode': statusCode,
        'body': json.dumps({
            "result": result,
            "errors": errors
        })
    }
