# Leadfamly backend test case
This repository contains a test case with the main purpose of evaluating technical capabilities that is backend related. A sample docker, docker-compose & NodeJS setup is already configured and ready to go. This does however not mean that you cannot swap NodeJS out with other languages or make your own customization to the repository as you see fit.

The maximum amount of hours allowed to spend on the task is 5 hours. Please try and stay within this limit. **We do not expect you to finish all aspects of the task.**

## Prerequisites
1. Docker & Docker Compose installed.
2. Mailchimp account (they're free to create).
3. AWS CLI tool installed (for publishing samples, an AWS account is NOT required).

## Introduction
To set the scene. You're tasked with creating a microservice that will send users over to an ESP (Email service provider). Communication with this microservice will happen through AWS EventBridge & in the end, end up in an AWS SQS queue that you will have to read from.

In this case the ESP that you will be integrating with is one called `mailchimp`.

The body of the event that you will have to read & process is as follows:

```json
{
    "Event": "campaign-esp-send",
    "Payload": {
        "Target": "mailchimp",
        "Configuration": {
            "ApiKey": "some-api-key",
            "DoubleOptIn": true,
            "UpdateIfExists": true,
            "ListId": "908e87634f"
        },
        "FieldMapping": {
            "FNAME": "Dannie",
            "EMAIL": "dannie@leadfamly.com"
        }
    }
}
```

Within each event payload you will find 3 important indicies:

1. Target
2. Configuration
3. FieldMapping

**Target:** ESP that the event is targeting.

**Configuration:**
 1) **ApiKey:** Mailchimp API key.
 2) **DoubleOptIn:** Whether or not double opt-in is enabled.
 3) **UpdateIfExists:** Whether or not it should update if a record exists.
 4) **ListId:** Mailchimp list id to send to.

**FieldMapping:** Key-value object where key is the respective field in Mailchimp & value is the value of this field to either update or create with.

## ESP capabilities
All ESPs have a set of capabilities that will determine what the processing of sending one over will look like. The 3 capabilities of a ESP is as follows:

1. search
2. update
3. create

In this case mailchimp supports both searching out existing records, updating existing records and creating new records. So the process of the ESP would look something like:

1. Search existing user out to see if they already exists.
2. If payload says to update existing users and user already exist - update it.
3. If payload says not to update existing users and user already exists - do nothing.
4. If user does not exists - attempt to create it.

## On completion
When you're finished and wish to send the project to your contact in Leadfamly. Fell free to either zip it and send it, or upload to Github and share a link to it.

## Final notes
There are samples in place for you to get started running your manual tests with. You'll find 2 samples under `samples` folder. One without updating & one with updating existing record. Fell free to add more samples or modify them to fit your test case.

The samples will through AWS cli send over messages to the AWS SQS queue that is running locally through docker. So before you attempt to send over test queue messages you need to run `docker-compose up`.