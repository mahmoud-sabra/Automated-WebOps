# Stage 1: Build the Application
FROM node:alpine AS builder

ENV WD /app
# Add a work directory
WORKDIR ${WD}
# Cache and Install dependencies
COPY package.json package-lock.json ./
RUN npm install 
# Copy app files
COPY . .
# Build the app
RUN npm run build

# Stage 2: Create a Minimal Runtime Image
FROM node:alpine
# Set the work directory
WORKDIR /app
# Copy the built files from the builder stage
COPY --from=builder /app/build /app/
# Expose the port
EXPOSE 3000
# Set the entrypoint command to start the application
CMD ["npx", "serve"]
