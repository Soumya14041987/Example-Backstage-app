FROM node:20-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY .yarn .yarn
COPY .yarnrc.yml package.json yarn.lock ./
COPY packages ./packages
COPY plugins ./plugins
COPY app-config.yaml app-config.yaml

# Install node modules
RUN yarn install --immutable

# Build the app
RUN yarn tsc
RUN yarn build:backend --config app-config.yaml

# Start the app
CMD ["node", "packages/backend", "--config", "app-config.yaml"]
