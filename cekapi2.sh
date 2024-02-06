# Function to print a red cross
print_cross() {
  echo -e "[\e[31m✘\e[0m] Not Enabled"
}

# Function to enable API
enable_api() {
  local api=$1
  echo "Enabling $api..."
  gcloud services enable "$api" --project=project-gmail-custom-command
}

# List of APIs to check and enable
apis=(
  "1. admin.googleapis.com"
  "2. drive.googleapis.com"
  "3. gmail.googleapis.com"
  "4. calendar-json.googleapis.com"
  "5. people.googleapis.com"
  "6. tasks.googleapis.com"
  "7. forms.googleapis.com"
  "8. groupsmigration.googleapis.com"
  "9. vault.googleapis.com"
  "10. storage-component.googleapis.com"
)

echo "Checking if APIs have been enabled:"
echo "------------------------------------------------------------------"
echo "| API # | Service                                 | Status      |"
echo "------------------------------------------------------------------"

# Check and enable APIs that are not verified
for ((i=0; i<${#apis[@]}; i++)); do
  api="${apis[$i]}"
  api_number=$(echo "$api" | cut -d' ' -f1)
  api_name=$(echo "$api" | cut -d' ' -f2-)
  status=$(gcloud services list --format="value(NAME)" --filter="NAME:$api_name")

  if [[ "$status" != "$api_name" ]]; then
    enable_api "$api_name"
    status=$(gcloud services list --format="value(NAME)" --filter="NAME:$api_name")
  fi

  status_message=$(print_cross)
  [[ "$status" == "$api_name" ]] && status_message="Enabled"

  printf "| %-5s | %-38s | %-11s |\n" "$api_number" "$api_name" "$status_message"
done

echo "------------------------------------------------------------------"
