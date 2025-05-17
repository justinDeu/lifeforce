mod models;
mod routes;
mod templates;

use std::net::SocketAddr;
use std::str::FromStr;
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

    // Get server host and port from environment variables with fallbacks
    let host = std::env::var("SERVER_HOST").unwrap_or_else(|_| "127.0.0.1".to_string());
    let port = std::env::var("SERVER_PORT")
        .unwrap_or_else(|_| "3000".to_string())
        .parse::<u16>()
        .expect("SERVER_PORT must be a valid port number");

    // Check for database configuration
    let database_url = std::env::var("DATABASE_URL").unwrap_or_else(|_| {
        let db_user = std::env::var("POSTGRES_USER").unwrap_or_else(|_| "postgres".to_string());
        let db_pass = std::env::var("POSTGRES_PASSWORD").unwrap_or_else(|_| "postgres".to_string());
        let db_host = std::env::var("POSTGRES_HOST").unwrap_or_else(|_| "localhost".to_string());
        let db_port = std::env::var("POSTGRES_PORT").unwrap_or_else(|_| "5432".to_string());
        let db_name = std::env::var("POSTGRES_DB").unwrap_or_else(|_| "lifeforce".to_string());
        
        format!("postgres://{}:{}@{}:{}/{}", db_user, db_pass, db_host, db_port, db_name)
    });
    
    tracing::info!("Using database URL: {}", database_url);

    // Build the application router
    let app = routes::create_router();

    // Define the address to run the server on
    let ip_addr = std::net::IpAddr::from_str(&host)
        .unwrap_or_else(|_| std::net::IpAddr::from([127, 0, 0, 1]));
    let addr = SocketAddr::from((ip_addr, port));
    tracing::info!("Starting server on {}", addr);

    // Create a TCP listener
    let listener = TcpListener::bind(addr).await.unwrap();
    
    // Start the server
    axum::serve(listener, app).await.unwrap();
}