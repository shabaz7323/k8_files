FROM node:18-alpine
WORKDIR /k8s_FILES
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
