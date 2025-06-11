# ---
# Stage 1: Build the Rust application
FROM rust:latest AS builder
WORKDIR /app

# Copy your Cargo.toml, Cargo.lock, AND YOUR ENTIRE SOURCE CODE.
# This crucial step ensures Cargo has all necessary files (including 'src' directory)
# to resolve dependencies and compile your project in the subsequent build step.
COPY Cargo.toml Cargo.lock ./
COPY . .

# Build dependencies and the application in release mode.
# Cargo will now find your 'src' directory and manifest targets correctly.
# '--workspace' is useful if your Rust project is part of a workspace.
# '--frozen' ensures reproducible builds by preventing Cargo.lock modifications.
RUN cargo build --release --workspace --frozen

# ---
# Stage 2: Create a minimal production image
FROM debian:bookworm-slim

# If your Rust application links against musl for a smaller, statically linked binary,
# you might consider using 'alpine:latest' or even 'scratch'.
# FROM alpine:latest # Requires specific Rust toolchain setup (e.g., rustup target add x86_64-unknown-linux-musl)
# FROM scratch       # Only for truly static binaries with no external dependencies

WORKDIR /app

# Copy the built binary from the builder stage.
# IMPORTANT: 'rst' here must match the actual name of your compiled Rust binary.
# This is typically the 'name' field from your Cargo.toml (e.g., if 'name = "todo_app"', then use 'todo_app').
COPY --from=builder /app/target/release/rst ./rst

# If your Rust application requires specific system libraries (e.g., OpenSSL for HTTPS requests),
# you'll need to install them here. Uncomment and adjust as necessary.
# RUN apt-get update && apt-get install -y --no-install-recommends openssl && rm -rf /var/lib/apt/lists/*

# Expose the port your application listens on. This is primarily for documentation and
# helps Docker know which ports to map when running the container (e.g., -p 8080:8080).
EXPOSE 8080

# Command to run your application when the container starts.
# Ensure './rst' is the correct executable name and path within the container.
CMD ["./rst"]
