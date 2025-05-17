# LifeForce

A personal website to manage the "forces of life": money, time, health, and more. Currently focused on financial management.

## Features

- Budget tracking and management
- Bank account integration
- Investment tracking
- Time management (coming soon)
- Health tracking (coming soon)

## Technology Stack

- **Backend**: Rust with Axum web framework
- **Database**: PostgreSQL with SQLx
- **Frontend**: HTMX + Askama templates + TailwindCSS
- **Authentication**: JWT (planned)

## Getting Started

### Prerequisites

- Rust (latest stable)
- Node.js and npm (for TailwindCSS)
- PostgreSQL

### Installation

1. Clone the repository
2. Install dependencies:

```bash
# Install Rust dependencies
cargo install sqlx-cli
cargo build

# Install Node.js dependencies
npm install
```

3. Configure the database:

```bash
# Create the database
createdb lifeforce

# Run migrations
sqlx migrate run
```

4. Build the CSS:

```bash
npm run build:css
```

5. Run the application:

```bash
cargo run
```

Visit `http://localhost:3000` in your browser.

## Development

For development with live reloading, you can use the provided script:

```bash
./dev.sh
```

This will:
- Install cargo-watch if needed
- Install npm dependencies if needed
- Start the development server with auto-reload
- Watch for changes in Rust files and restart the server
- Watch for changes in templates, CSS, and JS files and refresh the browser

You need to have the following tools installed:
- cargo-watch (will be installed automatically if missing)
- npm

## Building for Production

To build the application for production:

```bash
./build.sh
```

This will compile the CSS with minimization and build the Rust application in release mode.

## Architecture

The application follows a clean architecture approach:

- `src/models`: Data models and database entities
- `src/routes`: API routes and controllers
- `src/templates`: Askama template handling
- `templates/`: HTML templates
- `static/`: Static assets (CSS, JS, images)
- `migrations/`: Database migrations

## License

This project is licensed under the MIT License - see the LICENSE file for details.