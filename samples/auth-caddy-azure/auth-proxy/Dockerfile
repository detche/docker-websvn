# Build a custom caddy executable with the caddy-security module.
FROM caddy:2.6.4-builder AS builder
RUN xcaddy build --with github.com/greenpau/caddy-security

# Build our caddy image using our custom executable and config
FROM caddy:2.6.4
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY Caddyfile /etc/caddy/Caddyfile
