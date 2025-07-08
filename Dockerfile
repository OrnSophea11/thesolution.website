# Stage 1: Build the React Vite app
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN yarn install

# Copy the rest of the source code
COPY . .

# Build the app
RUN yarn run build

# Stage 2: Serve the build using nginx
FROM nginx:alpine

# Copy build files from the previous stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy custom nginx config (optional)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
