import boto3
import os
import requests

cognito_client = boto3.client('cognito-idp')

USER_POOL_ID = os.environ['USER_POOL_ID']
API_ENDPOINT = "https://example.com/api/endpoint"

def lambda_handler(event, context):
    cpf = event['cpf']
    body = event

    username = cpf
    password = cpf

    auth_parameters = {
        'USERNAME': username,
        'PASSWORD': password
    }

    try:
        cognito_client.admin_create_user(
            UserPoolId=USER_POOL_ID,
            Username=username,
            TemporaryPassword=password
        )
        cognito_client.admin_set_user_password(
            UserPoolId=USER_POOL_ID,
            Username=username,
            Password=password,
            Permanent=True
        )

        response = requests.post(API_ENDPOINT, json=body)

        if response.status_code == 200:
            # Retorna a resposta da API diretamente
            return {
                'statusCode': 200,
                'body': response.json()  # Assumindo que a API retorna um JSON
            }
        else:
            return {
                'statusCode': response.status_code,
                'body': {
                    'message': 'Erro ao chamar a API',
                    'error': response.text
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
