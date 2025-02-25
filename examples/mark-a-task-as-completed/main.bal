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
    clientId: clientId,
    clientSecret: clientSecret,
    refreshToken: refreshToken,
    credentialBearer: oauth2:POST_BODY_BEARER
};
// Create a new HubSpot owners client using the OAuth config.
final hstasks:Client hubspot = check new ({auth});
final string taskIdToUpdate = "78340683468";

public function main() returns error? {
    hstasks:SimplePublicObjectWithAssociations response = check hubspot->/[taskIdToUpdate].get(properties = ["hs_task_subject", "hs_task_status"]);
    string? currentStatus = response.properties["hs_task_status"];
    if currentStatus != "COMPLETED" {
        hstasks:SimplePublicObject responseUpdated = check hubspot->/[taskIdToUpdate].patch(payload = {
            objectWriteTraceId: "string",
            properties: {
                "hs_task_status": "COMPLETED"
            }
        });
        io:println("Task was in '", currentStatus, "' status and is now updated to 'Completed' status.");
        io:println("Updated Task Details: ", responseUpdated);
    } else {
        io:println("Task is already completed");
    }
}
