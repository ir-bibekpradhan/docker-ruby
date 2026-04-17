# ---- Build stage ----
FROM ruby:3.3-slim AS builder

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock* ./
RUN bundle install --without development test --jobs 4 --retry 3

# ---- Runtime stage ----
FROM ruby:3.3-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq5 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY lib/ ./lib/

# Non-root user
RUN useradd --create-home appuser
USER appuser

ENV APP_NAME=docker-ruby \
    APP_ENV=production \
    BUNDLE_PATH=/usr/local/bundle

CMD ["ruby", "lib/app.rb"]
