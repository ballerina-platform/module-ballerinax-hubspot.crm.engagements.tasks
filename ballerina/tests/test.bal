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

import ballerina/http;
import ballerina/oauth2;
import ballerina/test;

configurable boolean isLiveServer = ?;
final string serviceUrl = isLiveServer ? "https://api.hubapi.com/crm/v3/objects/tasks" : "http://localhost:9090";
configurable  string clientId=?;
configurable  string clientSecret = ?;
configurable string refreshToken = ?;

isolated function initClient() returns Client|error {
    if isLiveServer {
        OAuth2RefreshTokenGrantConfig auth = {
            clientId: clientId,
            clientSecret: clientSecret,
            refreshToken: refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        };
        return check new ({auth}, serviceUrl);
    }
    return check new ({
        auth: {
            token: "test-token"
        }
    }, serviceUrl);
}

final Client taskClient = check initClient();
final string testTaskId = "76798578391";
final string updateTestTaskId = "76798578391";
final string deletedTaskId = "76798588649";
final string testBatchTaskId1 = "77255886563";
final string testBatchTaskId2 = "77606927069";
final string updateTestsubject = "test update task";
final string testBatchTaskArchieveId1 = "77151529671";
final string testBatchTaskArchieveId2 = "77151529672";
final string testBatchTaskUpdated1 = "77200500438";
final string testBatchTaskUpdated2 = "77195047646";

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetTasksById() returns error? {
    SimplePublicObjectWithAssociations response = check taskClient->/[testTaskId];
    if response is SimplePublicObjectWithAssociations {
    test:assertTrue(response.length() > 0, msg = "Task retrieval failed. Please check the input data or server response for issues.");
    }
}

@test:Config { 
    groups: ["live_tests", "mock_tests"]  
}
isolated function testUpdateTask() returns error? {
    SimplePublicObject response = check taskClient->/[updateTestTaskId].patch(payload = {
        objectWriteTraceId: "string",
        properties: {
            "hs_task_subject": updateTestsubject
        }
    });
    if response is SimplePublicObject {
    test:assertTrue(response.length() > 0,msg="Task update failed. Please check the input data or server response for issues.");

}
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testTaskDeleteById() returns error? {
    http:Response response = check taskClient->/[deletedTaskId].delete();
    test:assertTrue(response.statusCode == 204,msg="Task deletion failed. Please check the input data or server response for issues.");
}

@test:Config { 
    groups: ["live_tests", "mock_tests"]  
}
isolated function testTasksBatchRead() returns error? {
    BatchReadInputSimplePublicObjectId batchTaskInput = {inputs: [{"id": testBatchTaskId1}, {"id": testBatchTaskId2}], propertiesWithHistory: ["hs_task_subject", "hs_timestamp"], properties: ["hs_task_subject", "hs_task_status"]};
    BatchResponseSimplePublicObject response = check taskClient->/batch/read.post(payload = batchTaskInput);
    if response is BatchResponseSimplePublicObject {
    test:assertTrue(response.results.length() > 0, msg = "Batch task read failed. Please check the input data or server response for issues.");
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"]  
}
isolated function  testTaskSearch() returns error? {
    PublicObjectSearchRequest taskSearchInput={query:"test"};
    CollectionResponseWithTotalSimplePublicObjectForwardPaging response= check taskClient->/search.post(payload=taskSearchInput);
    if response is CollectionResponseWithTotalSimplePublicObjectForwardPaging {
    test:assertTrue(response?.results.length()>0, msg="Task search failed. Please check the input data or server response for issues.");
    }
}

@test:Config { 
    groups: ["live_tests", "mock_tests"]
}
isolated function testBatchTasksUpdate() returns error? {
    BatchInputSimplePublicObjectBatchInput batchTaskInput = {
        inputs: [
            {
                objectWriteTraceId: "string1",
                id: "77200500438",
                properties: {
                    "hs_task_subject": "Updating with test batch update1"
                }
            },
            {
                objectWriteTraceId: "string2",
                id: "77195047646",
                properties: {
                    "hs_task_subject": "Updating with test batch update2"
                }
            }
        ]
    };
    BatchResponseSimplePublicObject response = check taskClient->/batch/update.post(payload = batchTaskInput);
    if response is BatchResponseSimplePublicObject {
    test:assertTrue(response?.results.length()>0, msg = "Batch task update failed. Please check the input data or server response for issues.");
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"]  
}
isolated function testTasksBatchCreate() returns error?
{
    BatchInputSimplePublicObjectInputForCreate batchTaskInput = {
        inputs: [
            {
                associations: [
                    {
                        types: [
                            {
                                associationCategory: "HUBSPOT_DEFINED",
                                associationTypeId: 192
                            }
                        ],
                        to: {
                            id: "38349931215"
                        }
                    }
                ],
                objectWriteTraceId: "string2",
                properties: {
                    "hs_timestamp": "2025-10-30T03:30:17.883Z",
                    "hs_task_body": "test batch task  body1",
                    "hs_task_subject": "test batch task subject1",
                    "hs_task_status": "WAITING",
                    "hs_task_priority": "HIGH",
                    "hs_task_type": "TODO"
                }
            },
            {
                associations: [
                    {
                        types: [
                            {
                                associationCategory: "HUBSPOT_DEFINED",
                                associationTypeId: 192
                            }
                        ],
                        to: {
                            id: "38349931215"
                        }
                    }
                ],
                objectWriteTraceId: "string1",
                properties: {
                    "hs_timestamp": "2025-10-30T03:30:17.883Z",
                    "hs_task_body": "test batch task body2",
                    "hs_task_subject": "test batch task subject2",
                    "hs_task_status": "WAITING",
                    "hs_task_priority": "HIGH",
                    "hs_task_type": "TODO"
                }
            }
        ]
    };
    BatchResponseSimplePublicObject response = check taskClient->/batch/create.post(payload = batchTaskInput);
    if response is BatchResponseSimplePublicObject {
    test:assertTrue(response?.results.length()>0, msg = "Batch task creation failed. Please check the input data or server response for issues.");
    }

}

@test:Config { 
    groups: ["live_tests", "mock_tests"] 
}
isolated function testTasksBatchArchieve() returns error? {
    BatchInputSimplePublicObjectId batchTaskInput = {inputs: [{id: testBatchTaskArchieveId1}, {id: testBatchTaskArchieveId2}]};
    http:Response response = check taskClient->/batch/archive.post(payload = batchTaskInput);
    test:assertTrue(response.statusCode == 204, msg = "Batch task archieve failed. Please check the input data or server response for issues.");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testTaskCreate() returns error? {
    SimplePublicObjectInputForCreate taskCreateInput = {
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
        objectWriteTraceId: "string",
        properties: {
            "hs_timestamp": "2025-02-20T03:30:17.883Z",
            "hs_task_body": "Sample task body",
            "hs_task_priority": "LOW",
            "hs_task_type": "TODO",
            "hs_task_subject": "A sample task for testing task creation"
        }
    };
    SimplePublicObject response = check taskClient->/.post(payload = taskCreateInput);
    test:assertTrue(response is SimplePublicObject, msg = "Task creation failed.");
}

@test:Config { 
    groups: ["live_tests", "mock_tests"]  
}
isolated function testTasksGetPage() returns error? {
    CollectionResponseSimplePublicObjectWithAssociationsForwardPaging response = check taskClient->/.get();
    if response is CollectionResponseSimplePublicObjectWithAssociationsForwardPaging {
    test:assertTrue(response.results.length() > 0, msg = "Failed to retrieve tasks of a page");
    }
}

@test:Config{
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetTasksByInvalidId() returns error?{
     SimplePublicObject|error response =  taskClient->/["-1"];
     test:assertTrue(response is error,msg="Expected an error response for invalid taskId");
}

@test:Config{
    groups: ["live_tests", "mock_tests"]
}
isolated function testTaskCreateWithInvalidAssociationToId() returns error?
{
    SimplePublicObjectInputForCreate taskCreateInput = {
        associations: [
            {
                to: {
                    id: "-1"
                },
                types: [
                    {
                        associationCategory: "HUBSPOT_DEFINED",
                        associationTypeId: 204
                    }
                ]
            }
        ],
        objectWriteTraceId: "string",
        properties: {
            "hs_timestamp": "2025-02-20T03:30:17.883Z",
            "hs_task_body": "Sample task body",
            "hs_task_priority": "LOW",
            "hs_task_type": "TODO",
            "hs_task_subject": "A sample task for testing task creation"
        }
    };
    SimplePublicObject|error response =  taskClient->/.post(payload = taskCreateInput);
    test:assertTrue(response is error,msg="Expected an error response for invalid associationId");
}

@test:Config{
    groups: ["live_tests", "mock_tests"]
}
isolated function testTaskUpdateWithInvalidId() returns error?
{
    SimplePublicObject|error response =  taskClient->/["-1"].patch(payload = {
        objectWriteTraceId: "string",
        properties: {
            "hs_task_subject": updateTestsubject
        }
    });
    test:assertTrue(response is error,msg="Expected an error response for invalid taskId");
}

@test:Config{
    groups: ["live_tests", "mock_tests"]
}
isolated function testTaskBatchCreateWithInvalidAssociationToId() returns error?
{
    BatchInputSimplePublicObjectInputForCreate batchTaskInput = {
        inputs: [
            {
                associations: [
                    {
                        to: {
                            id: "-1"
                        },
                        types: [
                            {
                                associationCategory: "HUBSPOT_DEFINED",
                                associationTypeId: 204
                            }
                        ]
                    }
                ],
                objectWriteTraceId: "string2",
                properties: {
                    "hs_timestamp": "2025-10-30T03:30:17.883Z",
                    "hs_task_body": "test batch task  body1",
                    "hs_task_subject": "test batch task subject1",
                    "hs_task_status": "WAITING",
                    "hs_task_priority": "HIGH",
                    "hs_task_type": "TODO"
                }
            },
            {
                associations: [
                    {
                        to: {
                            "id": "-2"
                        },
                        types: [
                            {
                                "associationCategory": "HUBSPOT_DEFINED",
                                "associationTypeId": 204
                            }
                        ]
                    }
                ],
                objectWriteTraceId: "string1",
                properties: {
                    "hs_timestamp": "2025-10-30T03:30:17.883Z",
                    "hs_task_body": "test batch task body2",
                    "hs_task_subject": "test batch task subject2",
                    "hs_task_status": "WAITING",
                    "hs_task_priority": "HIGH",
                    "hs_task_type": "TODO"
                }
            }
        ]
    };
    BatchResponseSimplePublicObject|error response =  taskClient->/batch/create.post(payload = batchTaskInput);
    test:assertTrue(response is error,msg="Expected an error response for invalid associationId");
}


