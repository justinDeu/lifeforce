# Commands
- `dev.sh`: start the development on ports 3000 and live reloading on 3001
- `cargo run` : builds and runs the server on port 3000

# Git Strategy
- Each issue is solved in its own git branch named with two or three hyphen seperated words for the issue followed by the number
- when branches are merged they will be squashed so commit as much as you want with descriptive comments.
- the final commit message should be the message for when the issue is closed
- __NEVER__ close any github PRs or issues

# Tech Stack
- codebase is written in rust with shared types between the frontend and backend
- axum is used for the backend
- htmx and askama templates are used for the frontend
- postgres is used for the database

# Critical Rules - DO NOT VIOLATE

- **NEVER create mock data or simplified components** unless explicitly told to do so
- **NEVER replace existing complex components with simplified versions** - always fix the actual problem
- **ALWAYS work with the existing codebase** - do not create new simplified alternatives
- **ALWAYS find and fix the root cause** of issues instead of creating workarounds
- __NEVER__ update any database schemas withuot explicit permission
- When debugging issues, focus on fixing the existing implementation, not replacing it
- When something doesn't work, debug and fix it - don't start over with a simple version
