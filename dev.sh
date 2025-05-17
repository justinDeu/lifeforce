#!/bin/bash

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

# Start development environment
echo "Starting LifeForce development server with live reload..."
npm run dev