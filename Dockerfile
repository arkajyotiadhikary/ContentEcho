# Use the official Node.js image as the base image
FROM node:18

# Set the working directory
WORKDIR /

# Copy the package.json and package-lock.json files
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Copy the .env file
COPY .env .env

# Build the Strapi admin panel
RUN npm run build

# Expose the Strapi port
EXPOSE 1337

# Start the Strapi server in development mode
CMD ["npm", "run", "develop"]
