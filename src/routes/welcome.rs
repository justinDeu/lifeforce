use axum::{Router, routing::get, response::IntoResponse};
use askama::Template;
use askama_axum::Response;

pub fn router() -> Router {
    Router::new()
        .route("/", get(welcome))
}

#[derive(Template)]
#[template(path = "welcome.html")]
struct WelcomeTemplate {
    title: String,
}

async fn welcome() -> Response {
    let template = WelcomeTemplate {
        title: "Welcome to LifeForce".to_string(),
    };
    
    template.into_response()
}