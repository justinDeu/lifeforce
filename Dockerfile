FROM rust:1.76-slim as builder

WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y build-essential pkg-config libpq-dev libssl-dev && \
    rm -rf /var/lib/apt/lists/*

# Copy manifests
COPY Cargo.toml Cargo.lock ./

# Cache dependencies - create a dummy main.rs and build
RUN mkdir -p src && \
    echo "fn main() {println!(\"dummy\");}" > src/main.rs && \
    cargo build --release && \
    rm -f target/release/deps/lifeforce*

# Copy actual source code
COPY . .

# Build the application
RUN cargo build --release

# Runtime stage
FROM debian:bookworm-slim

WORKDIR /app

# Install runtime dependencies
RUN apt-get update && \
    apt-get install -y libpq5 ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copy the binary from the builder stage
COPY --from=builder /app/target/release/lifeforce /app/lifeforce
COPY --from=builder /app/migrations /app/migrations
COPY --from=builder /app/static /app/static
COPY --from=builder /app/templates /app/templates

# Set environment variables
ENV SERVER_HOST=0.0.0.0
ENV SERVER_PORT=3000

# Expose the port
EXPOSE 3000

# Run the binary
CMD ["./lifeforce"]