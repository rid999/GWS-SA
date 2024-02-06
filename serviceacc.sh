# Generate a random number between 1000 and 9999
random_number=$((RANDOM % 9000 + 1000))

# Custom name for the service account
service_account_name="Migration$random_number"

# Create a service account
gcloud iam service-accounts create $service_account_name --display-name="$service_account_name"

# Get the email of the created service account
service_account_email=$(gcloud iam service-accounts list --filter="displayName:$service_account_name" --format="value(email)")

# Give owner permission to the service account
gcloud projects add-iam-policy-binding project-gmail-custom-command --member="serviceAccount:$service_account_email" --role="roles/owner"

# Create a p12 key for the service account
gcloud iam service-accounts keys create "$service_account_name-key.p12" --iam-account="$service_account_email"
