#!/bin/bash

# Set the path to your Git repository
repo_path="/Users/kapa/Downloads/git/wedding-website"

# Set the branch you want to work with
branch_name="main"

# Navigate to the repository
cd $repo_path || exit 1

# Ensure the repository is clean before starting
if [[ -n $(git status -s) ]]; then
  echo "Error: There are uncommitted changes in the repository. Please commit or stash them first."
  exit 1
fi

# Pull changes from the remote repository
git pull origin $branch_name

# Add changes to the staging area
git add .

# Check if there are changes to commit
if [[ -n $(git status -s) ]]; then
  # Commit changes with a custom message
  git commit -m "Automated commit - $(date)"
  
  # Push changes to the remote repository
  git push origin $branch_name
  
  # Merge with a condition (e.g., only if a specific file exists)
  if [[ -f "your_condition_file.txt" ]]; then
    # Merge changes into the main branch
    git checkout $branch_name
    git merge origin/$branch_name
    git push origin $branch_name
  else
    echo "Condition not met. Skipping merge."
  fi
else
  echo "No changes to commit. Exiting without pushing or merging."
fi

echo "Script completed successfully."
