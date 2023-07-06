# DAPR DEMO

This repository contains examples of using DAPR with Azure Container Instances. Currently The examples focus on using DAPR with Azure backend components.
The demo includes:
1. State management with AzureBlobStorage


## Instruction
The demo requires that the DAPR resources files be uploaded to an Azure File Share that is mounted on the DAPR container. By default this example will use the test storage account `arnavteststorageaccount`.
Another storage account can be specified by setting environment variables appropriately.

The example uses the following environment variables
```bash
SUBSCRIPTION_ID
CONTAINER_GROUP_NAME
RESOURCE_GROUP
STORAGE_SHARE_NAME
STORAGE_ACCOUNT_NAME
```

To run the example set the appropriate environment variables and run 
```bash
make create-container-group
```


## Modifying the example
To make updates to the example modify the source file under `src/` and build and push the docker image using 
```bash
export IMAGE_REPO=<image repository>
export IMAGE_NAME=<image name>
export IMAGE_TAG=<image tag>

make docker-build-image

make docker-push-image
```

this will build the container image and push to the specified repository. Please update the image repository in the containerinstance.json file to pull the correct image.
