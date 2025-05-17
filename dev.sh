#!/bin/bash
set -e

# Check if we're running in Docker
if [ -f "/.dockerenv" ]; then
    echo "Running in Docker container"
    # Docker-specific settings
    HOST="0.0.0.0"
else
    echo "Running locally"
    # Local settings
    HOST="localhost"
    
    # Change to script directory for local execution
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    cd "$SCRIPT_DIR"
fi

# Check if cargo-watch is installed
if ! command -v cargo-watch &> /dev/null; then
    echo "cargo-watch not found, installing..."
    cargo install --locked cargo-watch@8.4.0
fi

# Check if npm dependencies are installed
if [ ! -d "node_modules" ]; then
    echo "Node modules not found, installing dependencies..."
    npm install
fi

# Build Tailwind CSS
echo "Building initial CSS..."
npm run build:css

# Start development environment with live reload
echo "Starting LifeForce development server with live reload..."

# Use cargo-watch to restart the server when Rust files change
cargo watch -x 'run' -w src &

# Watch for CSS changes in separate process
npm run watch:css &

# Start browser-sync for auto-refreshing on file changes
node_modules/.bin/browser-sync start --proxy "${HOST}:3000" --port 3001 --files 'templates/**/*.html,static/css/*.css,static/js/*.js' &

# Wait for all background processes
wait