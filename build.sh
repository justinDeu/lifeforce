#!/bin/bash

echo "Building LifeForce for production..."

# Compile TailwindCSS with minimization
echo "Building and minimizing CSS..."
NODE_ENV=production npm run build:css

# Build Rust application in release mode
echo "Building Rust application in release mode..."
cargo build --release

echo "Build complete! Production binary is located at: target/release/lifeforce"