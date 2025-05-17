#!/bin/bash
set -e

# Ensure we're in the app directory
cd /app

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

# Use cargo-watch to restart the server when Rust files change
cargo watch -x 'run' -w src &

# Watch for CSS changes in separate process
npm run watch:css &

# Start browser-sync for auto-refreshing on file changes
node_modules/.bin/browser-sync start --proxy '0.0.0.0:3000' --port 3001 --host 0.0.0.0 --files 'templates/**/*.html,static/css/*.css,static/js/*.js' &

# Wait for all background processes
wait