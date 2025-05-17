#!/bin/bash
set -e

# Parse command line arguments
APP_PORT=${1:-3000}
BROWSER_SYNC_PORT=$((APP_PORT + 1))

# Function to clean up processes on exit
cleanup() {
    echo "Shutting down services..."
    # Kill all child processes
    pkill -P $$ || true
    # Kill any processes that might still be listening on the ports
    lsof -ti:${APP_PORT} | xargs kill -9 2>/dev/null || true
    lsof -ti:${BROWSER_SYNC_PORT} | xargs kill -9 2>/dev/null || true
    exit 0
}

# Set up trap to catch Ctrl+C and other termination signals
trap cleanup SIGINT SIGTERM EXIT

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

echo "Starting server on port ${APP_PORT} with browser-sync on port ${BROWSER_SYNC_PORT}"

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

# Set environment variable for server port
export SERVER_PORT=${APP_PORT}

# Use cargo-watch to restart the server when Rust files change
cargo watch -x 'run' -w src &

# Watch for CSS changes in separate process
npm run watch:css &

# Start browser-sync for auto-refreshing on file changes
node_modules/.bin/browser-sync start --proxy "${HOST}:${APP_PORT}" --port ${BROWSER_SYNC_PORT} --files 'templates/**/*.html,static/css/*.css,static/js/*.js' &

# Wait for all background processes
wait
