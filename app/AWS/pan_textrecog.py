import boto3
import json
import re
import os

def lambda_handler(event, context):
    try:
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

    object_key = f'pan/{phone_number}/image.jpeg'

    # Initialize AWS Rekognition client
    rekognition_client = boto3.client('rekognition')

    try:
        # Call Rekognition to detect text in the image from S3
        response = rekognition_client.detect_text(
            Image={'S3Object': {'Bucket': bucket_name, 'Name': object_key}}
        )
        
        # Process the detected text and extract information
        detected_text = [text['DetectedText'] for text in response['TextDetections']]

        # Initialize a dictionary to hold PAN card information
        pan_info = {
            'Name': None,
            'DOB': None,
            'PAN Number': None
        }

        # Define regex patterns to extract information
        dob_pattern = re.compile(r'\d{2}/\d{2}/\d{4}')  # Date of birth pattern
        pan_pattern = re.compile(r'^[A-Z]{5}\d{4}[A-Z]$') # PAN card number pattern
        name_pattern = re.compile(r'NAME\s*:\s*([A-Z]+(?: [A-Z]+)+)')  # Name pattern

        for text in detected_text:
            # Check for Name using regex search
            if not pan_info['Name']:
                name_match = name_pattern.search(text)
                if name_match:
                    pan_info['Name'] = name_match.group(1).strip()

            # Check for DOB using regex search
            if not pan_info['DOB']:
                dob_match = dob_pattern.search(text)
                if dob_match:
                    pan_info['DOB'] = dob_match.group()
            
            # Check for PAN number using regex search
            if not pan_info['PAN Number']:
                pan_match = pan_pattern.search(text)
                if pan_match:
                    pan_info['PAN Number'] = pan_match.group().replace(' ', '')

        # Remove None values from the dictionary
        pan_info = {k: v for k, v in pan_info.items() if v}

        return {
            'statusCode': 200,
            'body': json.dumps(pan_info)
        }

    except Exception as e:
        return {'statusCode': 500, 'body': json.dumps(f'Error calling Rekognition: {str(e)}')}
