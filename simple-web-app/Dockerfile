# Use the official Nginx image
FROM nginx:alpine

# Set working directory inside container
WORKDIR /usr/share/nginx/html

# Remove default nginx static files
RUN rm -rf ./*

# Copy our app into the container
COPY . .

# Expose port 80 for HTTP
EXPOSE 80
