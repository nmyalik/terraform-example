#!/bin/bash

# -e  Exit immediately if a command exits with a non-zero status
# -u  Treat unset variables as an error when substituting
# -o pipefail  The return value of a pipeline is the status of
#              the last command to exit with a non-zero status
set -euo pipefail

> services.txt

DATE_FORMAT="%Y-%m-%d"
END_DATE=$(gdate +$DATE_FORMAT)
START_DATE=$(gdate --date="$(gdate +%Y%m01)" +$DATE_FORMAT)

for region in $(aws ec2 describe-regions --output text | cut -f4)
do
  services=$(aws ce get-cost-and-usage --time-period Start="$START_DATE",End="$END_DATE" --granularity MONTHLY --metrics "BlendedCost" "UnblendedCost" "NetAmortizedCost" "AmortizedCost" "NetUnblendedCost" "UsageQuantity" "NormalizedUsageAmount" --group-by '[{"Type": "DIMENSION", "Key": "LINKED_ACCOUNT"}, {"Type": "DIMENSION", "Key": "SERVICE"}]' --filter "{ \"Dimensions\": { \"Key\": \"REGION\", \"Values\": [\"${region}\"] } }" | jq '.ResultsByTime[].Groups[].Keys[1]')
  if [ -z "$services" ]; then
    echo -e "You don't have active services in region - $region." >> services.txt
  else
    echo -e "\nActive services in region - $region:" >> services.txt
    echo -e "$services \n\n" >> services.txt
  fi
done
