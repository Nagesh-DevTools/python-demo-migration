cat > app.py << 'EOF'
#!/usr/bin/env python3
"""
Simple Python Flask application for demo purposes.
Matches the TeamCity build configuration.
"""

from flask import Flask, jsonify
import os
import sys

app = Flask(__name__)

# Get environment variables from TeamCity/GitHub Actions
APP_VERSION = os.getenv('APP_VERSION', '1.0.0')
ENVIRONMENT = os.getenv('ENVIRONMENT', 'development')
PYTHON_VERSION = os.getenv('PYTHON_VERSION', '3')

@app.route('/')
def hello():
    """Root endpoint"""
    return jsonify({
        'message': 'Hello from Python Demo App',
        'version': APP_VERSION,
        'environment': ENVIRONMENT,
        'python_version': PYTHON_VERSION
    })

@app.route('/health')
def health():
    """Health check endpoint"""
    return jsonify({
        'status': 'healthy',
        'version': APP_VERSION
    }), 200

@app.route('/info')
def info():
    """Application info endpoint"""
    return jsonify({
        'app_name': 'Python Demo Application',
        'version': APP_VERSION,
        'environment': ENVIRONMENT,
        'python_version': sys.version
    })

if __name__ == '__main__':
    print(f"Starting app version {APP_VERSION} in {ENVIRONMENT} environment")
    app.run(host='0.0.0.0', port=5000, debug=(ENVIRONMENT == 'development'))
EOF
