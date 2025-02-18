_Author_:@ChathuraIshara \
_Created_:2025/02/14\
_Updated_:2025/02/17\
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from HubSpot CRM Tasks. 
The OpenAPI specification is obtained from [Hubspot Api Reference](https://github.com/HubSpot/HubSpot-public-api-spec-collection/blob/main/PublicApiSpecs/CRM/Tasks/Rollouts/424/v3/tasks.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.


1. Change the url property of the servers object

* Original: `https://api.hubapi.com`
* Updated: `https://api.hubapi.com/crm/v3/objects/tasks`
* Reason: This change of adding the common prefix /crm/v3/objects/tasks to the base url makes it easier to access endpoints using the client.

2. Update the API Paths

* Original: Paths included common prefix above in each endpoint. (eg: `/crm/v3/objects/tasks`)
* Updated: Common prefix is now removed from the endpoints as it is included in the base URL.
* Reason: This change simplifies the API paths, making them shorter and more readable.

3. Update the date-time into datetime to make it compatible with the ballerina type conversions

* Original: `"format": "date-time"`
* Updated: `"format": "datetime"`
* Reason: The `date-time` format is not compatible with the OpenAPI tool. Therefore, it is updated to `datetime` to make it compatible with the tool.

4. Update API Summary and Description Fields

* Original: Some API endpoints had one-word summaries, and some lacked description fields entirely.
* Updated: Changed one-word summaries to more meaningful summaries and added detailed description fields where they were missing.
* Reason: Improves clarity and provides better context for understanding the API.


## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/openapi.json --mode client --license docs/license.txt -o ballerina
```
Note: The license year is hardcoded to 2025, change if necessary.
