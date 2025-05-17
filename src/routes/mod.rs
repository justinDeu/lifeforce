mod welcome;

use axum::Router;
use tower_http::services::ServeDir;

pub fn create_router() -> Router {
    Router::new()
        .merge(welcome::router())
        .nest_service("/static", ServeDir::new("static"))
}