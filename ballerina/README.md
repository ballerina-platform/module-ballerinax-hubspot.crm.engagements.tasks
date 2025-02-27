## Overview

[HubSpot](https://www.hubspot.com/) is an AI-powered customer relationship management (CRM) platform.

The `ballerinax/module-ballerinax-hubspot.crm.engagements.tasks` connector offers APIs to connect and interact with the [Hubspot Engagements Tasks API](https://developers.hubspot.com/docs/guides/api/crm/engagements/tasks) endpoints, specifically based on the HubSpot REST API.

## Setup guide

To use the HubSpot Engagements Tasks connector, you must have access to the HubSpot API through a HubSpot developer account and a HubSpot App under it. Therefore, you need to register for a developer account at HubSpot if you don't have one already.

### Step 1: Login to a HubSpot developer account

If you have an account already, go to the [HubSpot developer portal](https://app.hubspot.com/)

If you don't have a HubSpot Developer Account you can sign up to a free account [here](https://developers.hubspot.com/get-started)

### Step 2: Create a developer test account (Optional)

Within app developer accounts, you can create [developer test accounts](https://developers.hubspot.com/beta-docs/getting-started/account-types#developer-test-accounts) to test apps and integrations without affecting any real HubSpot data.

**Note: These accounts are only for development and testing purposes. In production you should not use developer test accounts.**

1. Go to Test Account section from the left sidebar.
   ![Hubspot developer portal](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.engagements.tasks/refs/heads/main/docs/resources/test_acc_1.png)

2. Click Create developer test account.
   ![Hubspot developer testacc](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.engagements.tasks/refs/heads/main/docs/resources/test_acc_2.png)

3. In the dialogue box, give a name to your test account and click create.
   ![Hubspot developer testacc3](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.engagements.tasks/refs/heads/main/docs/resources/test_acc_3.png)

### Step 3: Create a HubSpot app 

1. In your developer account, navigate to the "Apps" section. Click on "Create App"
   ![Hubspot app creation 1](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.engagements.tasks/refs/heads/main/docs/resources/create_app_1.png)

2. Provide the necessary details, including the app name and description.

### Step 4: Configure the authentication flow

1. Move to the Auth Tab.
   ![Hubspot app creation 2](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.engagements.tasks/refs/heads/main/docs/resources/create_app_2.png)

2. In the Scopes section, add necessary scopes for your app using the "Add new scope" button.
   ![Hubspot set scope](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.engagements.tasks/refs/heads/main/docs/resources/set_scope.png)

3. Add your Redirect URI in the relevant section. You can also use localhost addresses for local development purposes. Click Create App.
   ![Hubspot create app final](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.engagements.tasks/refs/heads/main/docs/resources/create_app_final.png)

### Step 5: Get your client id and client secret

- Navigate to the Auth section of your app. Make sure to save the provided Client ID and Client Secret.
  ![Hubspot get credentials](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.engagements.tasks/refs/heads/main/docs/resources/get_credentials.png)

### Step 6: Setup authentication flow

Before proceeding with the Quickstart, ensure you have obtained the Access Token using the following steps:

1. Create an authorization URL using the following format:

   ```
   https://app.hubspot.com/oauth/authorize?client_id=<YOUR_CLIENT_ID>&scope=<YOUR_SCOPES>&redirect_uri=<YOUR_REDIRECT_URI>
   ```

   Replace the `<YOUR_CLIENT_ID>`, `<YOUR_REDIRECT_URI>`, and `<YOUR_SCOPES>` with your specific value.

2. Paste it in the browser and select your developer test account to install the app when prompted.
3. A code will be displayed in the browser. Copy the code.
4. Run the following curl command. Replace the `<YOUR_CLIENT_ID>`, `<YOUR_REDIRECT_URI>`, and `<YOUR_CLIENT_SECRET>` with your specific value. Use the code you received in the above step 3 as the `<CODE>`.

   - Linux/macOS

     ```bash
     curl --request POST \
     --url https://api.hubapi.com/oauth/v1/token \
     --header 'content-type: application/x-www-form-urlencoded' \
     --data 'grant_type=authorization_code&code=<CODE>&redirect_uri=<YOUR_REDIRECT_URI>&client_id=<YOUR_CLIENT_ID>&client_secret=<YOUR_CLIENT_SECRET>'
     ```

   - Windows

     ```bash
     curl --request POST ^
     --url https://api.hubapi.com/oauth/v1/token ^
     --header 'content-type: application/x-www-form-urlencoded' ^
     --data 'grant_type=authorization_code&code=<CODE>&redirect_uri=<YOUR_REDIRECT_URI>&client_id=<YOUR_CLIENT_ID>&client_secret=<YOUR_CLIENT_SECRET>'
     ```

   This command will return the access token necessary for API calls.

   ```json
   {
     "token_type": "bearer",
     "refresh_token": "<Refresh Token>",
     "access_token": "<Access Token>",
     "expires_in": 1800
   }
   ```

5. Store the access token securely for use in your application.

## Quickstart

To use the `HubSpot Engagements Tasks connector` in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

Import the `hubspot.crm.engagements.tasks` module and `oauth2` module.

```ballerina
import ballerinax/hubspot.crm.engagements.tasks as hstasks;
import ballerina/oauth2;
```

### Step 2: Instantiate a new connector

1. Instantiate a `hstasks:ConnectionConfig` with the obtained credentials and initialize the connector with it.

    ```ballerina
    configurable string clientId = ?;
    configurable string clientSecret = ?;
    configurable string refreshToken = ?;

    final hstasks:ConnectionConfig config = {
        auth : {
            clientId,
            clientSecret,
            refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        }
    };

    final hstasks:Client hsTasksClient = check new (config);
    ```

2. Create a `Config.toml` file and, configure the obtained credentials in the above steps as follows:

   ```toml
    clientId = <Client Id>
    clientSecret = <Client Secret>
    refreshToken = <Refresh Token>
   ```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations. A sample use case is shown below.

#### Create a task

```ballerina
public function main() returns error? {
    hstasks:SimplePublicObjectInputForCreate taskCreateInput = {
        "associations": [
            {
                "to": {
                    "id": "84267202257"
                },
                "types": [
                    {
                        "associationCategory": "HUBSPOT_DEFINED",
                        "associationTypeId": 204
                    }
                ]
            }
        ],
        "objectWriteTraceId": "string",
        "properties": {
            "hs_task_subject": "A sample task for example"
        }
    };
        hstasks:SimplePublicObject response = check hsTasksClient->/.post(payload = taskCreateInput);
}
```

#### Run the ballerina application

```bash
bal run
```

## Examples

The `HubSpot CRM Tasks` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.engagements.tasks/tree/main/examples), covering the following use cases:

