import json
import boto3
import cfnresponse

def lambda_handler(event, context):
    sns = boto3.client('sns')
    response_data = {}
    try:
        emails = event['ResourceProperties']['Emails']
        topic_arn = event['ResourceProperties']['TopicArn']
        
        if event['RequestType'] == 'Delete':
            # we can handle delete event 
            pass
        elif event['RequestType'] == 'Update':
            # we can handle  event 
            pass

        elif event['RequestType'] == 'Create':
            for email in emails:
                sns.subscribe(TopicArn=topic_arn, Protocol='email', Endpoint=email)           
        
        else: 
            pass
        # else:
        #     for email in emails:
        #         sns.subscribe(TopicArn=topic_arn, Protocol='email', Endpoint=email)
        
        cfnresponse.send(event, context, cfnresponse.SUCCESS, response_data)
    except Exception as e:
        print(e)
        cfnresponse.send(event, context, cfnresponse.FAILED, response_data)