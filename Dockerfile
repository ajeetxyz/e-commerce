# Use official Node.js image as the base image
FROM node:latest AS build

# Set working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application to the container
COPY . .

# Build React application
RUN npm run build

# Use NGINX as the web server
FROM nginx:alpine

# Copy built React application from previous stage to NGINX web root
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Command to start NGINX when container is run
CMD ["nginx", "-g", "daemon off;"]
