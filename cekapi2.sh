# Function to print a green checkmark
print_check() {
  echo -e "[\e[32m✔\e[0m] Verified"
}

# Function to print a red cross
print_cross() {
  echo -e "[\e[31m✘\e[0m] Not Verified"
}

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
echo "--------------------------------------------------------"

# Check and enable APIs that are not verified
for api in "${apis[@]}"; do
  status=$(gcloud services list --format="value(NAME)" --filter="NAME:$api")

  if [[ "$status" == "$api" ]]; then
    status_message=$(print_check)
  else
    status_message=$(print_cross)
    enable_api "$api"
    status_message+=" (Enabled)"
  fi

  printf "| %-38s | %-20s |\n" "$api" "$status_message"
done

echo "--------------------------------------------------------"
