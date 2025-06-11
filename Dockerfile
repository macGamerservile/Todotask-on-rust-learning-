
FROM rust:latest AS builder
WORKDIR /app


COPY Cargo.toml Cargo.lock ./
COPY . .

RUN cargo build --release --workspace --frozen


FROM debian:bookworm-slim



WORKDIR /app


COPY --from=builder /app/target/release/rst ./rst

EXPOSE 8080


CMD ["./rst"]
