use askama::Template;
use axum::{routing::get, Router};

use crate::templates::HtmlTemplate;

pub fn router() -> Router {
    Router::new().route("/", get(welcome))
}

#[derive(Template)]
#[template(path = "welcome.html")]
struct WelcomeTemplate {
    title: String,
    active_page: String,
}

async fn welcome() -> impl axum::response::IntoResponse {
    let template = WelcomeTemplate {
        title: "Welcome to LifeForce".to_string(),
        active_page: "dashboard".to_string(),
    };

    HtmlTemplate(template)
}
