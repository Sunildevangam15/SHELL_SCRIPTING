
#!/bin/bash

aws_regions=(ap-south-1 eu-east-1 eu-central-1 us-east 1)
echo "Getting VPC regions..."

for region in ${aws_regions[@]}; do
    echo "Getting VPC list in  $region"

    # Fetch VPC list for the current region
    vpc_list=$(aws ec2 describe-vpcs --region "$region" | jq -r .Vpcs[].VpcId)

    # Convert VPC list to an array
    vpc_arr=(${vpc_list[@]})

    # Check if VPCs exist in the region
    if [ ${#vpc_arr[@]} -gt 0 ]; then
        for vpc in ${vpc_arr[@]}; do
            echo "VPC ID is: $vpc"
        done
    else
        echo "No VPCs found. Exiting at region: $region"
        break
    fi

done