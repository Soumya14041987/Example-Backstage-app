# Impelmentation steps of launching Backstage in Ubuntu

Pre-requisities:-

1. If any older version exists , please check & uninstall the same :-
sudo apt remove nodejs -y

2.Now install &  verify nodejs & npm version
sudo curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install nodejs
node -v
npm -v

# Re-install dependencies

yarn install

# Now, try running the app again

yarn dev

# Check that backstage-cli is properly installed and available by running:

yarn list @backstage/cli

# Re-install the cli

yarn add @backstage/cli

# 🛠️ Step-by-Step: Add Docker Support to Your Backstage App

# Create a Dockerfile in the root directory

# Dockerfile
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


# Create a dockerignore file

node_modules
dist
*.log
.git


# Build the docker image

docker build -t backstage-app .

# Run the container

docker run -p 7007:7007 backstage-app

# To make some life easier you can add the following lines :-

"docker:build": "docker build -t backstage-app .",
"docker:up": "docker run -p 7007:7007 backstage-app"


# Then we can execute :-

yarn docker:build
yarn docker:up
