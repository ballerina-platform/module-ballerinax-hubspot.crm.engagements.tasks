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
import ballerina/log;

listener http:Listener httpListener = new (9090);

http:Service mockService = service object {
    # Archive a task
    #
    # + return - returns can be any of following types 
    # http:NoContent (No content)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function delete [string taskId]() returns http:Response|error {
        http:Response response = new;
        response.statusCode = 204;
        return response;
    }

    # List of the tasks
    #
    # + 'limit - The maximum number of results to display per page.
    # + after - The paging cursor token of the last successfully read resource will be returned as the `paging.next.after` JSON property of a paged response containing more results.
    # + properties - A comma separated list of the properties to be returned in the response. If any of the specified properties are not present on the requested object(s), they will be ignored.
    # + propertiesWithHistory - A comma separated list of the properties to be returned along with their history of previous values. If any of the specified properties are not present on the requested object(s), they will be ignored. Usage of this parameter will reduce the maximum number of objects that can be read by a single request.
    # + associations - A comma separated list of object types to retrieve associated IDs for. If any of the specified associations do not exist, they will be ignored.
    # + archived - Whether to return only results that have been archived.
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function get .(string? after, string[]? properties, string[]? propertiesWithHistory, string[]? associations, int:Signed32 'limit = 10, boolean archived = false) returns CollectionResponseSimplePublicObjectWithAssociationsForwardPaging|error {
        return
            {
            "results": [
                {
                    "id": "76578958019",
                    "properties": {
                        "hs_createdate": "2025-02-17T09:24:49.394Z",
                        "hs_lastmodifieddate": "2025-02-18T08:24:36.446Z",
                        "hs_object_id": "76578958019",
                        "hs_task_subject": "Hello task 1",
                        "hubspot_owner_id": null
                    },
                    "createdAt": "2025-02-16T12:15:45.113Z",
                    "updatedAt": "2025-02-16T12:15:45.724Z",
                    "archived": false
                },
                {
                    "id": "76798578391",
                    "properties": {
                        "hs_createdate": "2025-02-17T09:24:49.394Z",
                        "hs_lastmodifieddate": "2025-02-17T11:12:50.511Z",
                        "hs_object_id": "76798578391",
                        "hs_task_subject": "Hello task2",
                        "hubspot_owner_id": "77367890"
                    },
                    "createdAt": "2025-02-17T09:24:49.394Z",
                    "updatedAt": "2025-02-17T11:12:50.511Z",
                    "archived": false
                }
            ]
        };
    }

    # Read a task
    #
    # + properties - A comma separated list of the properties to be returned in the response. If any of the specified properties are not present on the requested object(s), they will be ignored.
    # + propertiesWithHistory - A comma separated list of the properties to be returned along with their history of previous values. If any of the specified properties are not present on the requested object(s), they will be ignored.
    # + associations - A comma separated list of object types to retrieve associated IDs for. If any of the specified associations do not exist, they will be ignored.
    # + archived - Whether to return only results that have been archived.
    # + idProperty - The name of a property whose values are unique for this object type
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function get [string taskId](string[]? properties, string[]? propertiesWithHistory, string[]? associations, string? idProperty, boolean archived = false) returns SimplePublicObjectWithAssociations|error|http:Response {
        if taskId == "-1"
        {
            http:Response response = new;
            response.statusCode = 404;
            return response;
        }
        else {
            SimplePublicObjectWithAssociations response = {
                "id": taskId,
                "properties": {
                    "hs_createdate": "2025-02-17T09:24:49.394Z",
                    "hs_lastmodifieddate": "2025-02-18T08:24:36.446Z",
                    "hs_object_id": "76798578391",
                    "hs_task_priority": "LOW",
                    "hs_task_subject": "Test task for mock service",
                    "hs_task_type": "TODO",
                    "hubspot_owner_id": "77367890"
                },
                "createdAt": "2025-02-18T07:55:49.513Z",
                "updatedAt": "2025-02-18T07:55:50.043Z",
                "archived": false
            };
            return response;
        }
    }

    # Update a task
    #
    # + idProperty - The name of a property whose values are unique for this object type
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function patch [string taskId](string? idProperty, @http:Payload SimplePublicObjectInput payload) returns SimplePublicObject|http:Response|error {
        if taskId == "-1" {
            http:Response response = new;
            response.statusCode = 404;
            return response;
        }
        else {
            SimplePublicObject response = {
                "id": taskId,
                "properties": {
                    "hs_all_owner_ids": "77367890",
                    "hs_created_by": "77367890",
                    "hs_created_by_user_id": "77367890",
                    "hs_createdate": "2025-02-18T07:55:49.513Z",
                    "hs_lastmodifieddate": "2025-02-18T07:55:50.043Z",
                    "hs_modified_by": "77367890",
                    "hs_object_id": "77483577066",
                    "hs_object_source": "CRM_UI",
                    "hs_object_source_id": "userId:77367890",
                    "hs_object_source_label": "CRM_UI",
                    "hs_object_source_user_id": "77367890",
                    "hs_pipeline": "3d314325-1b2a-4225-9388-375f49c57ec3",
                    "hs_pipeline_stage": "af0e6a5c-2ea3-4c72-b69f-7c6cb3fdb591",
                    "hs_task_subject": "Test task for mock service",
                    "hs_updated_by_user_id": "77367890",
                    "hs_user_ids_of_all_owners": "77367890",
                    "hubspot_owner_assigneddate": "2025-02-18T07:55:49.513Z",
                    "hubspot_owner_id": "77367890"
                },
                "createdAt": "2025-02-18T07:55:49.513Z",
                "updatedAt": "2025-02-18T07:55:50.043Z",
                "archived": false
            };
            return response;
        }

    }

    # Create a task
    #
    # + return - returns can be any of following types 
    # http:Created (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post .(@http:Payload SimplePublicObjectInputForCreate payload) returns SimplePublicObject|http:Response|error {
        string associationToId = payload.associations[0].to.id; // get the association id
        if associationToId == "-1"
        {
            http:Response response = new;
            response.statusCode = 404;
            return response;
        }
        else {
            SimplePublicObject response = {
                "id": "77597502155",
                "properties": {
                    "hs_body_preview": "Sample task body",
                    "hs_body_preview_html": "<html>\n <head></head>\n <body>\n Sample task body\n </body>\n</html>",
                    "hs_body_preview_is_truncated": "false",
                    "hs_createdate": "2025-02-18T08:46:39.901Z",
                    "hs_lastmodifieddate": "2025-02-18T08:46:39.901Z",
                    "hs_object_id": "77597502155",
                    "hs_object_source": "INTEGRATION",
                    "hs_object_source_id": "8111832",
                    "hs_object_source_label": "INTEGRATION",
                    "hs_task_body": "Sample task body",
                    "hs_task_completion_count": "0",
                    "hs_task_family": "SALES",
                    "hs_task_for_object_type": "OWNER",
                    "hs_task_is_all_day": "false",
                    "hs_task_is_completed": "0",
                    "hs_task_is_completed_call": "0",
                    "hs_task_is_completed_email": "0",
                    "hs_task_is_completed_linked_in": "0",
                    "hs_task_is_completed_sequence": "0",
                    "hs_task_is_overdue": "false",
                    "hs_task_is_past_due_date": "false",
                    "hs_task_missed_due_date": "false",
                    "hs_task_missed_due_date_count": "0",
                    "hs_task_priority": "LOW",
                    "hs_task_status": "NOT_STARTED",
                    "hs_task_subject": "A sample task for testing task creation",
                    "hs_task_type": "TODO",
                    "hs_timestamp": "2025-02-20T03:30:17.883Z"
                },
                "createdAt": "2025-02-18T08:46:39.901Z",
                "updatedAt": "2025-02-18T08:46:39.901Z",
                "archived": false
            };

            return response;
        }
    }

    # Archive a batch of tasks by ID
    #
    # + return - returns can be any of following types 
    # http:NoContent (No content)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post batch/archive(@http:Payload BatchInputSimplePublicObjectId payload) returns http:Response|error {
        http:Response response = new;
        response.statusCode = 204;
        return response;
    }

    # Create a batch of tasks
    #
    # + return - returns can be any of following types 
    # http:Created (successful operation)
    # http:MultiStatus (multiple statuses)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post batch/create(@http:Payload BatchInputSimplePublicObjectInputForCreate payload) returns BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors|http:Response|error {
        string associationToId1 = payload.inputs[0].associations[0].to.id; // get the associationTo id1
        string associationToId2 = payload.inputs[1].associations[0].to.id; // get the associationTo id2
        if associationToId1 == "-1" || associationToId2 == "-1"
        {
            http:Response response = new;
            response.statusCode = 404;
            return response;
        }
        else {
            BatchResponseSimplePublicObject response = {
                "status": "COMPLETE",
                "results": [
                    {
                        "id": "77255875305",
                        "properties": {
                            "hs_body_preview": "test batch task body2",
                            "hs_body_preview_html": "<html>\n <head></head>\n <body>\n test batch task body2\n </body>\n</html>",
                            "hs_body_preview_is_truncated": "false",
                            "hs_createdate": "2025-02-18T09:09:19.978Z",
                            "hs_lastmodifieddate": "2025-02-18T09:09:19.978Z",
                            "hs_object_id": "77255875305",
                            "hs_object_source": "INTEGRATION",
                            "hs_object_source_id": "8111832",
                            "hs_object_source_label": "INTEGRATION",
                            "hs_task_body": "test batch task body2",
                            "hs_task_completion_count": "0",
                            "hs_task_family": "SALES",
                            "hs_task_for_object_type": "OWNER",
                            "hs_task_is_all_day": "false",
                            "hs_task_is_completed": "0",
                            "hs_task_is_completed_call": "0",
                            "hs_task_is_completed_email": "0",
                            "hs_task_is_completed_linked_in": "0",
                            "hs_task_is_completed_sequence": "0",
                            "hs_task_is_overdue": "false",
                            "hs_task_is_past_due_date": "false",
                            "hs_task_missed_due_date": "false",
                            "hs_task_missed_due_date_count": "0",
                            "hs_task_priority": "HIGH",
                            "hs_task_status": "WAITING",
                            "hs_task_subject": "test batch task subject2",
                            "hs_task_type": "TODO",
                            "hs_timestamp": "2025-10-30T03:30:17.883Z"
                        },
                        "createdAt": "2025-02-18T09:09:19.978Z",
                        "updatedAt": "2025-02-18T09:09:19.978Z",
                        "archived": false,
                        "objectWriteTraceId": "string1"
                    },
                    {
                        "id": "77255875304",
                        "properties": {
                            "hs_body_preview": "test batch task body1",
                            "hs_body_preview_html": "<html>\n <head></head>\n <body>\n test batch task body1\n </body>\n</html>",
                            "hs_body_preview_is_truncated": "false",
                            "hs_createdate": "2025-02-18T09:09:19.978Z",
                            "hs_lastmodifieddate": "2025-02-18T09:09:19.978Z",
                            "hs_object_id": "77255875304",
                            "hs_object_source": "INTEGRATION",
                            "hs_object_source_id": "8111832",
                            "hs_object_source_label": "INTEGRATION",
                            "hs_task_body": "test batch task  body1",
                            "hs_task_completion_count": "0",
                            "hs_task_family": "SALES",
                            "hs_task_for_object_type": "OWNER",
                            "hs_task_is_all_day": "false",
                            "hs_task_is_completed": "0",
                            "hs_task_is_completed_call": "0",
                            "hs_task_is_completed_email": "0",
                            "hs_task_is_completed_linked_in": "0",
                            "hs_task_is_completed_sequence": "0",
                            "hs_task_is_overdue": "false",
                            "hs_task_is_past_due_date": "false",
                            "hs_task_missed_due_date": "false",
                            "hs_task_missed_due_date_count": "0",
                            "hs_task_priority": "HIGH",
                            "hs_task_status": "WAITING",
                            "hs_task_subject": "test batch task subject1",
                            "hs_task_type": "TODO",
                            "hs_timestamp": "2025-10-30T03:30:17.883Z"
                        },
                        "createdAt": "2025-02-18T09:09:19.978Z",
                        "updatedAt": "2025-02-18T09:09:19.978Z",
                        "archived": false,
                        "objectWriteTraceId": "string2"
                    }
                ],
                "startedAt": "2025-02-18T09:09:19.945Z",
                "completedAt": "2025-02-18T09:09:20.262Z"
            };
            return response;
        }
    }

    # Read a batch of tasks by internal ID, or unique property values
    #
    # + archived - Whether to return only results that have been archived.
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:MultiStatus (multiple statuses)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post batch/read(@http:Payload BatchReadInputSimplePublicObjectId payload, boolean archived = false) returns BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors|error {
        BatchResponseSimplePublicObject response = {
            "status": "COMPLETE",
            "results": [
                {
                    "id": "77255886563",
                    "properties": {
                        "hs_createdate": "2025-02-18T09:36:22.519Z",
                        "hs_lastmodifieddate": "2025-02-18T09:36:23.070Z",
                        "hs_object_id": "77255886563",
                        "hs_task_status": "NOT_STARTED",
                        "hs_task_subject": "Batch task1"
                    },
                    "propertiesWithHistory": {
                        "hs_task_body": [
                            {
                                "value": "Sample task body",
                                "timestamp": "2025-02-18T09:36:22.519Z",
                                "sourceType": "INTEGRATION",
                                "sourceId": "8111832"
                            }
                        ],
                        "hs_timestamp": [
                            {
                                "value": "2025-02-20T03:30:17.883Z",
                                "timestamp": "2025-02-18T09:36:22.519Z",
                                "sourceType": "INTEGRATION",
                                "sourceId": "8111832"
                            }
                        ]
                    },
                    "createdAt": "2025-02-18T09:36:22.519Z",
                    "updatedAt": "2025-02-18T09:36:23.070Z",
                    "archived": false
                },
                {
                    "id": "77606927069",
                    "properties": {
                        "hs_createdate": "2025-02-18T09:36:57.705Z",
                        "hs_lastmodifieddate": "2025-02-18T09:36:58.197Z",
                        "hs_object_id": "77606927069",
                        "hs_task_status": "NOT_STARTED",
                        "hs_task_subject": "Batch task2"
                    },
                    "propertiesWithHistory": {
                        "hs_task_body": [
                            {
                                "value": "Sample task body",
                                "timestamp": "2025-02-18T09:36:57.705Z",
                                "sourceType": "INTEGRATION",
                                "sourceId": "8111832"
                            }
                        ],
                        "hs_timestamp": [
                            {
                                "value": "2025-02-20T03:30:17.883Z",
                                "timestamp": "2025-02-18T09:36:57.705Z",
                                "sourceType": "INTEGRATION",
                                "sourceId": "8111832"
                            }
                        ]
                    },
                    "createdAt": "2025-02-18T09:36:57.705Z",
                    "updatedAt": "2025-02-18T09:36:58.197Z",
                    "archived": false
                }
            ],
            "startedAt": "2025-02-18T09:38:53.032Z",
            "completedAt": "2025-02-18T09:38:53.039Z"
        };
        return response;
    }

    # Update a batch of tasks by internal ID, or unique property values
    #
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:MultiStatus (multiple statuses)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post batch/update(@http:Payload BatchInputSimplePublicObjectBatchInput payload) returns BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors|error {
        BatchResponseSimplePublicObject response = {
            "status": "COMPLETE",
            "results": [
                {
                    "id": "77195047646",
                    "properties": {
                        "hs_createdate": "2025-02-17T17:13:54.986Z",
                        "hs_lastmodifieddate": "2025-02-17T17:30:25.243Z",
                        "hs_object_id": "77195047646",
                        "hs_object_source": "INTEGRATION",
                        "hs_object_source_id": "8111832",
                        "hs_object_source_label": "INTEGRATION",
                        "hs_pipeline": "3d314325-1b2a-4225-9388-375f49c57ec3",
                        "hs_pipeline_stage": "dd5826e4-c976-4654-a527-b59ada542e52",
                        "hs_task_subject": "Updating with test batch update2"
                    },
                    "createdAt": "2025-02-17T17:13:54.986Z",
                    "updatedAt": "2025-02-17T17:30:25.243Z",
                    "archived": false,
                    "objectWriteTraceId": "string2"
                },
                {
                    "id": "77200500438",
                    "properties": {
                        "hs_createdate": "2025-02-17T16:38:28.765Z",
                        "hs_lastmodifieddate": "2025-02-17T17:30:25.244Z",
                        "hs_object_id": "77200500438",
                        "hs_object_source": "INTEGRATION",
                        "hs_object_source_id": "8111832",
                        "hs_object_source_label": "INTEGRATION",
                        "hs_pipeline": "3d314325-1b2a-4225-9388-375f49c57ec3",
                        "hs_pipeline_stage": "dd5826e4-c976-4654-a527-b59ada542e52",
                        "hs_task_subject": "Updating with test batch update1"
                    },
                    "createdAt": "2025-02-17T16:38:28.765Z",
                    "updatedAt": "2025-02-17T17:30:25.244Z",
                    "archived": false,
                    "objectWriteTraceId": "string1"
                }
            ],
            "startedAt": "2025-02-18T09:47:19.539Z",
            "completedAt": "2025-02-18T09:47:19.621Z"
        };
        return response;
    }

    # Create or update a batch of tasks by unique property values
    #
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:MultiStatus (multiple statuses)
    # http:DefaultStatusCodeResponse (An error occurred.)
    // resource function post batch/upsert(@http:Payload BatchInputSimplePublicObjectBatchInputUpsert payload) returns BatchResponseSimplePublicUpsertObject|BatchResponseSimplePublicUpsertObjectWithErrors|error {
    // }

    # Search for tasks
    #
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post search(@http:Payload PublicObjectSearchRequest payload) returns CollectionResponseWithTotalSimplePublicObjectForwardPaging|error {
        CollectionResponseWithTotalSimplePublicObjectForwardPaging response = {
            "total": 2,
            "results": [
                {
                    "id": "76578958019",
                    "properties": {
                        "hs_createdate": "2025-02-16T12:15:45.113Z",
                        "hs_lastmodifieddate": "2025-02-16T12:15:45.724Z",
                        "hs_object_id": "76578958019",
                        "hs_task_body": "a task without associations",
                        "hs_task_status": "NOT_STARTED"
                    },
                    "createdAt": "2025-02-16T12:15:45.113Z",
                    "updatedAt": "2025-02-16T12:15:45.724Z",
                    "archived": false
                },
                {
                    "id": "76798585554",
                    "properties": {
                        "hs_createdate": "2025-02-17T10:52:27.816Z",
                        "hs_lastmodifieddate": "2025-02-17T10:52:28.299Z",
                        "hs_object_id": "76798585554",
                        "hs_task_body": "<div style=\"\" dir=\"auto\" data-top-level=\"true\"><br></div>",
                        "hs_task_status": "NOT_STARTED"
                    },
                    "createdAt": "2025-02-17T10:52:27.816Z",
                    "updatedAt": "2025-02-17T10:52:28.299Z",
                    "archived": false
                }
            ]
        };
        return response;

    }
};

function init() returns error? {
    if isLiveServer {
        log:printInfo("Skipping mock service initialization. Tests are configured to run against live server.");
        return;
    }
    log:printInfo("Tests are configured to run against mock server. Initializing mock service...");
    check httpListener.attach(mockService, "/");
    check httpListener.'start();
}
