# Examples

The `ballerinax/hubspot.crm.engagements.tasks` connector provides practical examples illustrating usage in various scenarios.

1. [Task management in HubSpot CRM](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.engagements.tasks/tree/main/examples/assign-or-extend-a-task) - This example checks a task's status in HubSpot CRM and updates it to "Completed" if necessary, ensuring efficient task management.

2. [Task completion and status change in HubSpot CRM](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.engagements.tasks/tree/main/examples/mark-a-task-as-completed) - This example searches for a task in HubSpot CRM by its subject, creating a new one if none exists or updating details like the due date and priority if found.

## Prerequisites

1. Generate HubSpot credentials to authenticate the connector as described in the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.engagements.tasks/blob/main/ballerina/Package.md#setup-guide).

2. For each example, create a `Config.toml` file the related configuration. Here's an example of how your `Config.toml` file should look:

    ```toml
    clientId = <Client Id>
    clientSecret = <Client Secret>
    refreshToken = <Refresh Token>
    ```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
