# Function to enable API
enable_api() {
  local api=$1
  echo "Enabling $api..."
  gcloud services enable "$api" --project=project-gmail-custom-command
}

# List of APIs to check and enable
apis=(
  "admin.googleapis.com"
  "drive.googleapis.com"
  "gmail.googleapis.com"
  "calendar-json.googleapis.com"
  "people.googleapis.com"
  "tasks.googleapis.com"
  "forms.googleapis.com"
  "groupsmigration.googleapis.com"
  "vault.googleapis.com"
  "storage-component.googleapis.com"
)

echo "Checking if APIs have been enabled:"
echo "------------------------------------------------------------------"
echo "| API # | Service                                 | Status      |"
echo "------------------------------------------------------------------"

# Check and enable APIs that are not verified
for ((i=0; i<${#apis[@]}; i++)); do
  api="${apis[$i]}"
  api_number=$((i+1))
  status=$(gcloud services list --format="value(NAME)" --filter="NAME:$api")

  if [[ "$status" != "$api" ]]; then
    enable_api "$api"
    status=$(gcloud services list --format="value(NAME)" --filter="NAME:$api")
  fi

  status_message="Not Enabled"
  [[ "$status" == "$api" ]] && status_message="Enabled"

  printf "| %-5s | %-38s | %-11s |\n" "$api_number" "$api" "$status_message"
done

echo "------------------------------------------------------------------"
