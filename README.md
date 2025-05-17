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

You can run LifeForce either using Docker or directly on your local machine.

### Option 1: Using Docker (Recommended)

#### Prerequisites

- Docker
- Docker Compose

#### Running with Docker Compose

1. Clone the repository

2. Create a `.env` file from the template:

```bash
cp .env.example .env
```

3. For development mode with live reloading:

```bash
docker-compose up app-dev
```

4. For production mode:

```bash
docker-compose --profile prod up app
```

Visit `http://localhost:3000` in your browser.

### Option 2: Local Installation

#### Prerequisites

- Rust (latest stable)
- Node.js and npm (for TailwindCSS)
- PostgreSQL

#### Installation

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

### Local Development

For local development with live reloading, you can use the provided script:

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

### Docker Development

For development using Docker:

```bash
docker-compose up app-dev
```

This provides:
- Live reloading of code changes
- PostgreSQL database configured and ready
- Mounted volumes for real-time code editing
- Cached Cargo dependencies for faster builds

Any changes to your files will be reflected immediately in the running container.

## Building for Production

### Local Build

To build the application for production locally:

```bash
./build.sh
```

This will compile the CSS with minimization and build the Rust application in release mode.

### Docker Production Build

To build and run the production version with Docker:

```bash
# Build the production image
docker-compose --profile prod build

# Run the production stack
docker-compose --profile prod up -d
```

The production Docker setup:
- Uses multi-stage builds for smaller images
- Optimizes the Rust build for release
- Properly configures the database
- Sets up appropriate environment variables

## Architecture

The application follows a clean architecture approach:

- `src/models`: Data models and database entities
- `src/routes`: API routes and controllers
- `src/templates`: Askama template handling
- `templates/`: HTML templates
- `static/`: Static assets (CSS, JS, images)
- `migrations/`: Database migrations

## Docker Configuration

The project includes Docker configuration files:

- `Dockerfile`: Production build configuration
- `Dockerfile.dev`: Development configuration with live reloading
- `docker-compose.yml`: Orchestration for both development and production
- `.env.example`: Template for environment variables

### Configuration Options

You can configure the application by setting environment variables in your `.env` file:

| Variable | Description | Default |
|----------|-------------|---------|
| `SERVER_HOST` | Host address to bind the server | `127.0.0.1` |
| `SERVER_PORT` | Port for the web server | `3000` |
| `POSTGRES_USER` | PostgreSQL username | `postgres` |
| `POSTGRES_PASSWORD` | PostgreSQL password | `postgres` |
| `POSTGRES_DB` | PostgreSQL database name | `lifeforce` |
| `POSTGRES_HOST` | PostgreSQL host address | `localhost` (or `db` in Docker) |
| `POSTGRES_PORT` | PostgreSQL port | `5432` |
| `RUST_LOG` | Logging configuration | `lifeforce=debug,tower_http=debug` |

## License

This project is licensed under the MIT License - see the LICENSE file for details.