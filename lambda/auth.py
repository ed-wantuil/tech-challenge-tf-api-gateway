import boto3
import os

cognito_client = boto3.client('cognito-idp')

USER_POOL_ID = os.environ['USER_POOL_ID']

def lambda_handler(event, context):
    username = event['username']
    email = event['email']

    try:
        user = cognito_client.admin_create_user(
            UserPoolId=USER_POOL_ID,
            Username=username,
            UserAttributes=[
                {
                    'Username': 'username'
                },
            ],
        )

        return {
            'statusCode': 200,
            'body': {
                'message': 'Usuário criado com sucesso',
                'user': user
            }
        }
    except cognito_client.exceptions.ClientError as e:
        return {
            'statusCode': 400,
            'body': {
                'message': 'Erro ao criar usuário',
                'error': str(e)
            }
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': {
                'message': 'Erro interno do servidor',
                'error': str(e)
            }
        }
