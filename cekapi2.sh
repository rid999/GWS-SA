# Function to check if API is enabled
check_api_status() {
  api_status=$(gcloud services list --format="value(NAME,STATUS)" --filter="NAME:$1" | cut -f2)
  [[ "$api_status" == "ENABLED" ]] && echo -e "[\e[32m✔\e[0m] Enabled" || echo -e "[\e[31m✘\e[0m] Disabled"
}

# Function to enable API
enable_api() {
  echo "Enabling $1..."
  gcloud services enable "$1"
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

# Enable APIs if not all are enabled
for api in "${apis[@]}"; do
  gcloud services enable "$api" 2>/dev/null
done

# Print summary
echo "Checking if APIs have been enabled:"
for api in "${apis[@]}"; do
  status_message=$(check_api_status "$api")
  printf "| %-38s | %-20s |\n" "$api" "$status_message"
done

# Enable disabled APIs
echo "Enabling disabled APIs:"
for api in "${apis[@]}"; do
  if [[ "$(check_api_status "$api")" == "[✘] Disabled" ]]; then
    enable_api "$api"
  fi
done
