FROM node:20-alpine  AS frontend-build
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build

FROM node:20-alpine
WORKDIR /app
COPY backend/package*.json ./
RUN npm install
COPY backend .
COPY --from=frontend-build /frontend/dist ../frontend/dist
EXPOSE 5000
CMD ["node", "server.js"]