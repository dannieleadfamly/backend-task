const { SQSClient, ReceiveMessageCommand } = require('@aws-sdk/client-sqs');

require('dotenv').config();

const client = new SQSClient({
    endpoint: process.env.SQS_ENDPOINT,
    region: process.env.SQS_REGION
});

async function processMessages () {
    try {
        const command = new ReceiveMessageCommand({
            QueueUrl: process.env.SQS_QUEUE_URL,
            WaitTimeSeconds: 18
        });

        console.log('checking for new messages...');

        const response = await client.send(command);

        if (response.Messages) {
            for (const message of response.Messages) {
                console.log('TODO:', message);
            }
        }

        processMessages();
    } catch (e) {
        console.error('[Exception]', e);
        setTimeout(processMessages, 2000);
    }
}

processMessages();