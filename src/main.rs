mod models;
mod routes;
mod templates;

use std::net::SocketAddr;
use tokio::net::TcpListener;
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

#[tokio::main]
async fn main() {
    // Initialize tracing
    tracing_subscriber::registry()
        .with(tracing_subscriber::EnvFilter::new(
            std::env::var("RUST_LOG").unwrap_or_else(|_| "lifeforce=debug,tower_http=debug".into()),
        ))
        .with(tracing_subscriber::fmt::layer())
        .init();

    // Load .env file if present
    if let Err(e) = dotenv::dotenv() {
        tracing::warn!("Failed to load .env file: {}", e);
    }

    // Build the application router
    let app = routes::create_router();

    // Define the address to run the server on
    let addr = SocketAddr::from(([127, 0, 0, 1], 3000));
    tracing::info!("Starting server on {}", addr);

    // Create a TCP listener
    let listener = TcpListener::bind(addr).await.unwrap();
    
    // Start the server
    axum::serve(listener, app).await.unwrap();
}