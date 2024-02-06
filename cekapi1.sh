# Generate an 8-digit random number
random_number=$(printf "%08d\n" $((RANDOM % 100000000)))

# Custom name for the project
project_name="Migration-$random_number"

# Create a new Google Cloud project
gcloud projects create "$project_name"

# Add your primary email as an owner to the newly created project
gcloud projects add-iam-policy-binding "$project_name" --member="user:YOUR_PRIMARY_EMAIL@gmail.com" --role="roles/owner"

# Set the newly created project as the default project
gcloud config set project "$project_name"
