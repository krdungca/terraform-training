#!/bin/bash
set -e  # Exit on any error

# Backend config files
DEV_BACKEND="dev.tfbackend"
STAGING_BACKEND="staging.tfbackend"
STATE_FILE=".terraform/terraform.tfstate"

# Function: detect current backend
get_current_backend() {
  if [ -f "$STATE_FILE" ]; then
    grep '"key":' "$STATE_FILE" | grep -Eo 'backends/(dev|staging)/state.tfstate' | awk -F'/' '{print $2}'
  else
    echo "none"
  fi
}

# Function: reinitialize Terraform with chosen backend
switch_backend() {
  local backend_file=$1
  echo "🔄 Reinitializing Terraform with $backend_file ..."
  terraform init -backend-config="$backend_file" -reconfigure -input=false >/dev/null
  echo "✅ Switched backend to $(basename "$backend_file" .tfbackend)"
}

# Detect current backend
CURRENT_BACKEND=$(get_current_backend)
echo "Current backend detected: $CURRENT_BACKEND"

# Ask which backend to switch to
read -p "Which backend do you want to switch to? (dev/staging): " TARGET_BACKEND

case "$TARGET_BACKEND" in
  dev)
    switch_backend "$DEV_BACKEND"
    ;;
  staging)
    switch_backend "$STAGING_BACKEND"
    ;;
  *)
    echo "Invalid backend. Please choose either 'dev' or 'staging'."
    exit 1
    ;;
esac

# Check state key file
./check-state-key-file.sh

# Verify new backend
NEW_BACKEND=$(get_current_backend)
echo "✅ Backend successfully switched from [$CURRENT_BACKEND] → [$NEW_BACKEND]"


