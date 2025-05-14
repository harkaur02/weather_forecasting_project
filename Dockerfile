# Stage 1: Build React app
FROM node:23-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Use Caddy and run as non-root user
FROM caddy:alpine

# Create a non-root user (e.g., appuser)
RUN adduser -D -u 10001 appuser

# Copy build files
COPY --from=builder /app/build /usr/share/caddy

# Set permissions (read-only for others)
RUN chown -R appuser:appuser /usr/share/caddy

# Switch to non-root user
USER appuser

EXPOSE 80

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
