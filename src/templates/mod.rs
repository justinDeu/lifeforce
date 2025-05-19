use askama::Template;
use axum::{
    http::{header, StatusCode},
    response::{Html, IntoResponse, Response},
};

pub struct HtmlTemplate<T>(pub T);

impl<T> IntoResponse for HtmlTemplate<T>
where
    T: Template,
{
    fn into_response(self) -> Response {
        // With Askama 0.14, render() returns Result<String, askama::Error>
        match self.0.render() {
            Ok(html) => {
                // Set content type and return the rendered HTML
                (
                    [(header::CONTENT_TYPE, "text/html; charset=utf-8")],
                    Html(html),
                )
                    .into_response()
            }
            Err(err) => {
                // Log the error and return a 500 response
                tracing::error!("Template rendering error: {}", err);
                StatusCode::INTERNAL_SERVER_ERROR.into_response()
            }
        }
    }
}

