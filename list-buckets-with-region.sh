
for bucket in $(aws s3 ls | awk '{print $3}'); do
  region=$(aws s3api get-bucket-location --bucket $bucket --query 'LocationConstraint' --output text)
  if [ "$region" = "None" ] || [ "$region" = "null" ]; then
    region="us-east-1"
  fi
  echo "$bucket : $region"
done

