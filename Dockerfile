# Use the official lightweight Node.js image
FROM node:14-alpine

# Set the working directory in the container
WORKDIR /app

# Copy only the package.json and package-lock.json first to leverage Docker caching
COPY package*.json ./

# Install project dependencies (skip optional dependencies to avoid platform-specific errors)
RUN npm install --legacy-peer-deps --no-optional

# Copy the entire project into the container
COPY . .

# Build the React application
RUN npm run build

# Install 'serve' globally to serve the build files
RUN npm install -g serve

# Expose port 3000 (the internal port used by the serve command)
EXPOSE 3000

# Use serve to serve the static files on port 3000 inside the container
CMD ["serve", "-s", "build", "-l", "3000"]
