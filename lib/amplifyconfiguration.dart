const amplifyconfig = '''{
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "ReportAPI": {
                    "endpointType": "REST",
                    "endpoint": "https://zqkjox3jo9.execute-api.ap-south-1.amazonaws.com/dev",
                    "region": "ap-south-1",
                    "authorizationType": "AWS_IAM"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "ap-south-1:82de5fb9-045e-4e36-ab9c-f60f49b8ed0f",
                            "Region": "ap-south-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "ap-south-1_R4zh629cc",
                        "AppClientId": "40hajbrs5n3aeclpkd6keb8n3s",
                        "Region": "ap-south-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "socialProviders": [],
                        "usernameAttributes": [
                            "EMAIL"
                        ],
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "helpnow6de94edfcb1e461e86861a790db46e17a26c4-dev",
                        "Region": "ap-south-1"
                    }
                },
                "DynamoDBObjectMapper": {
                    "Default": {
                        "Region": "ap-south-1"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "helpnow6de94edfcb1e461e86861a790db46e17a26c4-dev",
                "region": "ap-south-1",
                "defaultAccessLevel": "guest"
            },
            "awsDynamoDbStoragePlugin": {
                "partitionKeyName": "reportId",
                "region": "ap-south-1",
                "arn": "arn:aws:dynamodb:ap-south-1:736255089435:table/HelpNowReports-dev",
                "streamArn": "arn:aws:dynamodb:ap-south-1:736255089435:table/HelpNowReports-dev/stream/2025-07-20T06:06:08.504",
                "partitionKeyType": "S",
                "name": "HelpNowReports-dev"
            }
        }
    }
}''';
