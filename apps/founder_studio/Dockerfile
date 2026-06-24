# syntax=docker/dockerfile:1

FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

ARG BACKEND_URL=http://localhost:8000

COPY pubspec.yaml pubspec.lock ./
COPY l10n.yaml ./
RUN flutter pub get

COPY . .
RUN flutter gen-l10n \
    && flutter build web --release \
      --dart-define=BACKEND_URL=${BACKEND_URL}

FROM nginx:1.27-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD wget -qO- http://localhost:3000/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
