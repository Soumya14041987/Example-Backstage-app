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

![image](https://github.com/user-attachments/assets/5c9a8adc-b437-40d2-ac51-8f0cd8b300fc)


## Configuration of Github Authentication using OAuth :-

Go to GitHub Developer Settings > OAuth Apps.

Register a new app:

Homepage URL: http://localhost:3000

Authorization callback URL: http://localhost:7007/api/auth/github/handler/frame

Copy the Client ID and Client Secret.

In your Backstage app:

# app-config.local.yaml
auth:
  environment: development
  providers:
    github:
      development:
        clientId: ${AUTH_GITHUB_CLIENT_ID}
        clientSecret: ${AUTH_GITHUB_CLIENT_SECRET}

# Also, set these environment variables:
export AUTH_GITHUB_CLIENT_ID=your-client-id
export AUTH_GITHUB_CLIENT_SECRET=your-client-secret

# If you're using Github secrets then modify the app-config.yaml by following variables 

env:
  GITHUB_CLIENT_ID: ${{ secrets.GITHUB_CLIENT_ID }}
  GITHUB_CLIENT_SECRET: ${{ secrets.GITHUB_CLIENT_SECRET }}

  ## Then execute the below command to start the Backstage backend 

  yarn start 

  




