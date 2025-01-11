FROM node:18 as builder

WORKDIR /src

COPY package*.json .

RUN npm ci

COPY . .

RUN npm run build

FROM node:18-alpine as runner

ENV PORT=80
ENV NODE_ENV=production

WORKDIR /app

COPY package*.json .

RUN npm ci

COPY --from=builder /src/build /app/build

CMD ["npm", "start"]