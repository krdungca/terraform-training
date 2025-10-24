#!/bin/bash
set -e  # Exit on error

# Backend config files
DEV_BACKEND="dev.tfbackend"
STAGING_BACKEND="staging.tfbackend"
STATE_FILE=".terraform/terraform.tfstate"

# Function: detect current backend key
get_current_backend() {
  if [ -f "$STATE_FILE" ]; then
    grep '"key":' "$STATE_FILE" | grep -Eo 'backends/(dev|staging)/state.tfstate' | awk -F'/' '{print $2}'
  else
    echo "none"
  fi
}

# Function: reinitialize Terraform backend
reinit_backend() {
  local backend_file=$1
  echo "🔄 Reinitializing Terraform with $backend_file ..."
  terraform init -backend-config="$backend_file" -reconfigure -input=false >/dev/null
}

# Detect current backend
CURRENT_BACKEND=$(get_current_backend)
echo "Current backend detected: $CURRENT_BACKEND"

# Ask which environment to destroy
read -p "Which environment do you want to destroy? (dev/staging/none): " TARGET_DESTROY

case "$TARGET_DESTROY" in
  dev|staging)
    echo "🧹 Destroying $TARGET_DESTROY environment..."
    # Switch to selected backend before destroy
    if [ "$TARGET_DESTROY" = "dev" ]; then
      reinit_backend "$DEV_BACKEND"
    else
      reinit_backend "$STAGING_BACKEND"
    fi
    terraform apply -destroy -auto-approve
    ;;
  none)
    echo "Skipping destroy step."
    ;;
  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
esac

# Ask which environment to apply next
read -p "Which environment do you want to apply next? (dev/staging): " TARGET_APPLY

case "$TARGET_APPLY" in
  dev)
    reinit_backend "$DEV_BACKEND"
    echo "🚀 Applying DEV environment..."
    terraform apply -auto-approve
    ;;
  staging)
    reinit_backend "$STAGING_BACKEND"
    echo "🚀 Applying STAGING environment..."
    terraform apply -auto-approve
    ;;
  *)
    echo "Invalid apply environment. Exiting."
    exit 1
    ;;
esac

echo "✅ Done — environment switch and apply complete."

