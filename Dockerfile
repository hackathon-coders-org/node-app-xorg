FROM node:20-alpine
RUN apk upgrade --no-cache
WORKDIR /app
COPY package*.json ./
# npm is not needed at runtime; removing it also drops the CVEs bundled with the base image's npm.
RUN npm ci --omit=dev && npm cache clean --force \
 && rm -rf /usr/local/lib/node_modules/npm /usr/local/bin/npm /usr/local/bin/npx
COPY src ./src
EXPOSE 3001
USER node
CMD ["node", "src/index.js"]
