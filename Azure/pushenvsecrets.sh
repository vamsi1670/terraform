#!usr//bin/env/ bash

SOURCE_KV="source_kv_name"
DEST_KV="dest_kv"

keyvaultEntries=($(az keyvault secret list --vault-name $SOURCE_KV --query "[*].{name:name}" -o tsv))

for i in "${keyvaultEntries[@]}"

do
secret_value=($(az keyvault secret show --vault-name "${SOURCE_KV}" --name "${i}" --query value -o tsv) )
#echo $secret_value
if [[ $i =~ "-prf" ]]; then
   prf_secret_name=${i//-prf/}
   echo "Disabling old secret value of ${prf_secret_name}"
   az keyvault secret set-attributes --vault-name $DEST_KV --name "$prf_secret_name" --enabled=false > /dev/null
   echo "COpying $prf_secret_name to $DEST_KV and enable the secret value"
   az keyvault secret set --vault-name $DEST_KV --name "${prf_secret_name}" --value "$secret_value" > /dev/null
fi   
done
