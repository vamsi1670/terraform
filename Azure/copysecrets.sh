#!/bin/bash

SOURCE_KV="source_kv_name"
DEST_KV="dest_kv"
#List All secret names in the Source Keyvault
for secret in $(az keyvault secret list --vault-name "SOURCE_KV" --query "[].name" -o tsv; do
#Get the secret value
	value=$(az keyvault secret show --vault-name "$SOURCE_KV" --name "$secret" --query "value" -o tsv)
#set the secret in destination KV
	az keyvault secret set --vault-name "$DEST_KV" --name "$secret" --value "$value" 
echo "Copied secret : $secret"
done
