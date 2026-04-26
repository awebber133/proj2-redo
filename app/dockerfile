FROM node:18-alpine

WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if present)
COPY package*.json ./

RUN npm install --only=production

# Copy the rest of the app source
COPY . .

EXPOSE 3000

CMD ["npm", "start"]