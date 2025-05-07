# Build stage
FROM node:18 AS builder
WORKDIR /app

# Enable Yarn (required for monorepo/workspaces)
RUN corepack enable

# Copy everything & install dependencies
COPY . .
RUN yarn install --frozen-lockfile
RUN yarn build

# Production stage
FROM node:18-slim
WORKDIR /app

ENV NODE_ENV=production
RUN corepack enable

COPY --from=builder /app .

EXPOSE 3000
CMD ["yarn", "start"]
