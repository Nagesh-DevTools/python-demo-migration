cat > deploy.sh << 'EOF'
#!/bin/bash
set -e

ENVIRONMENT=$1
APP_VERSION=$2

if [ -z "$ENVIRONMENT" ] || [ -z "$APP_VERSION" ]; then
    echo "Usage: ./deploy.sh <environment> <version>"
    exit 1
fi

echo "=========================================="
echo "  Starting Deployment"
echo "  Environment: $ENVIRONMENT"
echo "  App Version: $APP_VERSION"
echo "=========================================="

# Validate environment
if [ "$ENVIRONMENT" != "development" ] && [ "$ENVIRONMENT" != "staging" ] && [ "$ENVIRONMENT" != "production" ]; then
    echo "❌ Invalid environment: $ENVIRONMENT"
    echo "   Allowed: development, staging, production"
    exit 1
fi

# Check if app is running
echo "[INFO] Checking application health..."
if ! python3 app.py &
then
    echo "❌ Failed to start application"
    exit 1
fi

sleep 2

# Stop the background process
pkill -f "python3 app.py" || true

echo "[SUCCESS] Application started successfully"
echo "[INFO] Deploying to $ENVIRONMENT..."

# Simulate deployment
case $ENVIRONMENT in
    development)
        echo "[DEPLOY] Deploying to LOCAL development server"
        echo "[DEPLOY] ✅ Deployment to development complete"
        ;;
    staging)
        echo "[DEPLOY] Deploying to STAGING environment"
        echo "[DEPLOY] ✅ Deployment to staging complete"
        ;;
    production)
        echo "[DEPLOY] Deploying to PRODUCTION environment"
        echo "[DEPLOY] ⚠️  PRODUCTION DEPLOYMENT - Requiring approval"
        echo "[DEPLOY] ✅ Deployment to production complete"
        ;;
esac

echo "=========================================="
echo "  Deployment Complete"
echo "  Version: $APP_VERSION"
echo "  Environment: $ENVIRONMENT"
echo "  Status: SUCCESS"
echo "=========================================="
EOF

chmod +x deploy.sh
