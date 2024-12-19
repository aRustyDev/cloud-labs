#!/usr/bin/env bash

export AWS_PROFILE=hacktricks
rm -f data.json
touch data.json
mkdir -p policies

function merge() {
  jq -s '.[0] * .[1]' data.json $1 > data.json
  rm -f $1
}

# Verify credentials
aws sts get-caller-identity | jq > whoami.json

export IAM_USERID=$(jq -r '.UserId' whoami.json)
export IAM_ACCT=$(jq -r '.Account' whoami.json)
export IAM_ARN=$(jq -r '.Arn' whoami.json)
export IAM_USERNAME=$(jq -r '.Arn' whoami.json | cut -d/ -f2)

aws iam list-user-policies --user-name $IAM_USERNAME | jq '.' > policies/user.json
aws iam list-attached-user-policies --user-name $IAM_USERNAME | jq '.' > policies/user-attached.json

# Enumerate Roles
aws iam list-roles | jq '.Roles[] | select(.RoleName | contains("lab"))' > roles/names.json
jq -c '.[].RoleName' ./roles/names.json | while read -r RoleName; do
    mkdir -p roles/$RoleName
    aws iam get-role --role-name $RoleName | jq '.' > roles/$RoleName/role.json
    aws iam list-attached-role-policies --role-name $RoleName | jq '.' > roles/$RoleName/attached-policies.json
    cp roles/$RoleName/attached-policies.json policies/$RoleName-attached.json
done

# Enumerate Policies
aws iam list-policies | jq '.Policies[].Arn' | grep lab

export IAM_POLICYARN=arn:aws:iam::277978271553:policy/iam_lab_3_start

aws iam get-policy --policy-arn $IAM_POLICYARN | jq
aws iam list-policy-versions --policy-arn $IAM_POLICYARN | jq
aws iam get-policy-version --policy-arn $IAM_POLICYARN --version-id v1 | jq

## Enumerate Groups
aws iam list-groups --user-name $IAM_USERNAME | jq '.' > groups/names.all.json
aws iam list-groups-for-user --user-name $IAM_USERNAME | jq '.' > groups/names.user.json
jq -c '.[].RoleName' ./groups/names.all.json | while read -r GroupName; do
    aws iam get-group --group-name $GroupName | jq '.' > groups/group.$GroupName.json
    aws iam list-group-policies --group-name $GroupName | jq '.' > policies/group.$GroupName.json
    aws iam list-attached-group-policies --group-name $GroupName | jq '.' > policies/group.$GroupName-attached.json
    jq -c '.[].PolicyName' ./policies/group.$GroupName.json | while read -r PolicyName; do
        aws iam get-group-policy --group-name $GroupName --policy-name $PolicyName> | jq '.' > policies/group.$GroupName-$PolicyName.json
        cp policies/group.$GroupName-$PolicyName.json groups/group.$GroupName-$PolicyName.json
    done
done

unset AWS_PROFILE
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
unset IAM_USERID
unset IAM_ACCT
unset IAM_ARN
unset IAM_USERNAME
unset IAM_POLICYARN
