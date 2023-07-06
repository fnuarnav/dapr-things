#! /bin/sh

## az login 
az login 

export STORAGE_ACCOUNT_KEY=$(az storage account keys list -g $RG_NAME -n $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)

sed "s/STORAGE_SHARE_NAME/$SHARE_NAME/" containerinstance.json > tempjson.json 
sed "s/STORAGE_ACCOUNT_NAME/$STORAGE_ACCOUNT_NAME/" tempjson.json -i 
sed "s|STORAGE_ACCOUNT_KEY|$STORAGE_ACCOUNT_KEY|" tempjson.json -i
sed "s/CONTAINER_GROUP_NAME/$CONTAINER_GROUP_NAME/" tempjson.json -i
