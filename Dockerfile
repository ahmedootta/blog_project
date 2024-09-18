# Use Ruby base image
ARG RUBY_VERSION=3.2.5
FROM ruby:$RUBY_VERSION-slim

# Set working directory
WORKDIR /rails

# Install dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libjemalloc2 \
    libvips \
    postgresql-client \
    build-essential \
    git \
    libpq-dev \
    pkg-config && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Set environment variables
ENV BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="production"

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

# Expose port for Rails server
EXPOSE 3000

# Set permissions for all users to access the /rails directory
RUN chmod -R 777 /rails
# Start Rails server by default
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

