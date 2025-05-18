#!/bin/bash

set -e

SERVER_HOST="localhost"
SERVER_PORT=${1:-3000}
BROWSER_SYNC_PORT=$((SERVER_PORT + 1))

# Function to clean up processes on exit
cleanup() {
    echo "Shutting down services..."
    # Kill all child processes
    pkill -P $$ || true
    # Kill any processes that might still be listening on the ports
    lsof -ti:${SERVER_PORT} | xargs kill -9 2>/dev/null || true
    lsof -ti:${BROWSER_SYNC_PORT} | xargs kill -9 2>/dev/null || true
    exit 0
}

# Set up trap to catch Ctrl+C and other termination signals
trap cleanup SIGINT SIGTERM EXIT

echo "Starting server on port ${SERVER_PORT} with browser-sync on port ${BROWSER_SYNC_PORT}"

# Check if cargo-watch is installed
if ! command -v cargo-watch &> /dev/null; then
    echo "cargo-watch not found, installing..."
    cargo install cargo-watch
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

# Start development environment
echo "Starting LifeForce development server with live reload..."
SERVER_PORT=${SERVER_PORT} SERVER_HOST=${SERVER_HOST} npm run dev
