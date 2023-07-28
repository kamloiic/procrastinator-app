# Stage 1: Build the client-side web application (no build needed in this case)
FROM nginx:alpine as builder
WORKDIR /tldr
COPY . .

# Stage 2: Serve the static files using Nginx
FROM nginx:alpine
COPY --from=builder /tldr /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
