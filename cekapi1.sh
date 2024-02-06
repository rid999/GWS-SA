# Generate a random number between 1000 and 9999
random_number=$((RANDOM % 9000 + 1000))

# Get the current date in YYYYMMDD format
current_date=$(date "+%Y%m%d")

# Custom name for the project
project_name="migration-$random_number-$current_date"

# Create a new Google Cloud project
gcloud projects create "$project_name"

# Add your primary email as an owner to the newly created project
gcloud projects add-iam-policy-binding "$project_name" --member="user:YOUR_PRIMARY_EMAIL@gmail.com" --role="roles/owner"

# Set the newly created project as the default project
gcloud config set project "$project_name"
