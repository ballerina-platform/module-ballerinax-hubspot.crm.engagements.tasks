// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerina/oauth2;
import ballerinax/hubspot.crm.engagements.tasks as hstasks;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

// Configure OAuth 2.0 refresh token grant details to connect to HubSpot.
hstasks:OAuth2RefreshTokenGrantConfig auth = {
    clientId,
    clientSecret,
    refreshToken,
    credentialBearer: oauth2:POST_BODY_BEARER
};
// Create a new HubSpot owners client using the OAuth config.
final hstasks:Client hubspot = check new ({auth});

public function main() returns error? {
    hstasks:SimplePublicObjectInputForCreate newTask = {
        associations: [
            {
                to: {
                    id: "84267202257"
                },
                types: [
                    {
                        associationCategory: "HUBSPOT_DEFINED",
                        associationTypeId: 204
                    }
                ]
            }
        ],
        properties: {
            "hs_timestamp": "2025-02-20T03:30:17.883Z",
            "hs_task_body": "Sample task body",
            "hs_task_priority": "HIGH",
            "hs_task_type": "TODO",
            "hs_task_subject": "Organize training session for new hires"
        }
    };
    //Check if the task exists by searching the task subject
    hstasks:PublicObjectSearchRequest taskSearchInput = {query: newTask.properties["hs_task_subject"]};
    hstasks:CollectionResponseWithTotalSimplePublicObjectForwardPaging response = check hubspot->/search.post(taskSearchInput);
    if response.total == 0{
        io:println("Task does not exist. Creating a new task.");
        hstasks:SimplePublicObject CreatedResponse = check hubspot->/.post(newTask);
        io:println("A new task has been created. Task Details: ", CreatedResponse);
    }
    else {
        // Update the task's due date to extend the deadline
        hstasks:SimplePublicObject responseUpdated = check hubspot->/[response.results[0].id].patch({
            properties: {
                "hs_timestamp": "2025-03-25T02:30:00Z"
            }
        }
        );
        io:println("The task is already available. Therefore, the task has been extended. Updated Task Details: ", responseUpdated);
    }
}
