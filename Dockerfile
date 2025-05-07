# Build stage
FROM node:18 AS builder
WORKDIR /app

# Install PNPM
RUN npm install -g pnpm

# Copy package files and install deps
COPY . .
RUN pnpm install
RUN pnpm build

# Production stage
FROM node:18-slim
WORKDIR /app

ENV NODE_ENV=production

# Copy built app from builder
COPY --from=builder /app .

# Expose port
EXPOSE 3000

# Start app
CMD ["pnpm", "start"]
