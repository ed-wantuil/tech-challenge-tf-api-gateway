import boto3
import os

# Initialize the Cognito IDP client
cognito_client = boto3.client('cognito-idp')

USER_POOL_ID = os.environ['USER_POOL_ID']
CLIENT_ID = os.environ['CLIENT_ID']

def lambda_handler(event, context):
    username = event['username']

    try:
        auth_response = cognito_client.admin_get_user(
            UserPoolId=USER_POOL_ID,
            Username=username
        )

        return {
            'statusCode': 200,
            'body': {
                'message': 'User authenticated successfully',
                'id_token': auth_response['AuthenticationResult']['IdToken']
            }
        }
    except cognito_client.exceptions.NotAuthorizedException:
        return {
            'statusCode': 401,
            'body': {
                'message': 'Authentication failed'
            }
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': {
                'message': 'Internal server error',
                'error': str(e)
            }
        }
