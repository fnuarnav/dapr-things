IMAGE_REPO ?= fnuarnav
IMAGE_NAME ?= dapr-example-http
IMAGE_TAG ?= test
SUBSCRIPTION_ID ?= da28f5e5-aa45-46fe-90c8-053ca49ab4b5
RESOURCE_GROUP ?= arnav-vk-test-rg
CONTAINER_GROUP_NAME ?= daprHttpContainerGroup
STORAGE_ACCOUNT_NAME ?= arnavteststorageaccount
STORAGE_SHARE_NAME ?= arnavtestdaprstorageshare
CONTAINER_FILE_NAME ?= containerinstance.json

IMAGE_URI=$(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG)

docker-build-image:
	docker build . -t $(IMAGE_URI)

docker-image-push:
	docker image push $(IMAGE_URI)


create-container-group: setup
	echo creating container group $(CONTAINER_GROUP_NAME) in resource group $(RESOURCE_GROUP)
	curl -X PUT \
		"https://management.azure.com/subscriptions/$(SUBSCRIPTION_ID)/resourcegroups/$(RESOURCE_GROUP)/providers/Microsoft.ContainerInstance/containerGroups/$(CONTAINER_GROUP_NAME)?api-version=2023-05-01" \
		-H "Authorization: Bearer `az account get-access-token --query "accessToken" -o tsv`" \
		-d @tempjson.json \
		-H "Content-type: application/json"
	
	rm tempjson.json

setup:
	RG_NAME=$(RESOURCE_GROUP) SHARE_NAME=$(STORAGE_SHARE_NAME) STORAGE_ACCOUNT_NAME=$(STORAGE_ACCOUNT_NAME) CONTAINER_FILE_NAME=$(CONTAINER_FILE_NAME) CONTAINER_GROUP_NAME=$(CONTAINER_GROUP_NAME) ./setup.sh
