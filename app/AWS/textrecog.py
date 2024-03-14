import boto3
import json
import re
import os

def lambda_handler(event, context):
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

    object_key = f'aadhar/{phone_number}/image.jpeg'

    # Initialize AWS Rekognition client
    rekognition_client = boto3.client('rekognition')

    try:
        # Call Rekognition to detect text in the image from S3
        response = rekognition_client.detect_text(
            Image={'S3Object': {'Bucket': bucket_name, 'Name': object_key}}
        )
        
        # Process the detected text and extract information
        detected_text = [text['DetectedText'] for text in response['TextDetections']]

        # Initialize a dictionary to hold Aadhar card information
        aadhar_info = {
            'Name': None,
            'DOB': None,
            'Gender': None,
            'Aadhar Number': None,
            'VID': None,
            'Phone Number': None
        }

        # Define regex patterns to extract information
        dob_pattern = re.compile(r'\d{2}/\d{2}/\d{4}')  # Date of birth pattern
        aadhar_pattern = re.compile(r'\d{4} \d{4} \d{4}')  # Aadhar card number pattern
        vid_pattern = re.compile(r'VID \d{16}')  # Virtual ID pattern
        gender_pattern = re.compile(r'(?i)(male|female|other)')  # Gender pattern
        phone_pattern = re.compile(r'\d{10}')  # Phone number pattern

        name_pattern = re.compile(r'[A-Z][a-z]+(?: [A-Z][a-z]+)+')  # Name pattern

        for text in detected_text:
            # Check for Name using regex search
            if not aadhar_info['Name']:
                name_match = name_pattern.search(text)
                if name_match:
                    aadhar_info['Name'] = name_match.group()

            # Check for DOB using regex search
            if not aadhar_info['DOB']:
                dob_match = dob_pattern.search(text)
                if dob_match:
                    aadhar_info['DOB'] = dob_match.group()
            
            # Check for gender using regex search
            if not aadhar_info['Gender']:
                gender_match = gender_pattern.search(text)
                if gender_match:
                    aadhar_info['Gender'] = gender_match.group().capitalize()
            
            # Check for Aadhar number using regex search
            if not aadhar_info['Aadhar Number']:
                aadhar_match = aadhar_pattern.search(text)
                if aadhar_match:
                    aadhar_info['Aadhar Number'] = aadhar_match.group().replace(' ', '')
            
            # Check for VID using regex search
            if not aadhar_info['VID']:
                vid_match = vid_pattern.search(text)
                if vid_match:
                    aadhar_info['VID'] = vid_match.group().replace('VID', '').strip()
            
            # Check for Phone number using regex search
            if not aadhar_info['Phone Number']:
                phone_match = phone_pattern.search(text)
                if phone_match:
                    aadhar_info['Phone Number'] = phone_match.group()

        # Remove None values from the dictionary
        aadhar_info = {k: v for k, v in aadhar_info.items() if v}

        return {
            'statusCode': 200,
            'body': json.dumps(aadhar_info)
        }

    except Exception as e:
        return {'statusCode': 500, 'body': json.dumps(f'Error calling Rekognition: {str(e)}')}
