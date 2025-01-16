FROM node:22 AS build

WORKDIR /app

COPY app.js package*.json .

RUN npm ci --only=production

FROM gcr.io/distroless/nodejs22-debian12

COPY --from=build /app /app

WORKDIR /app

CMD ["app"]