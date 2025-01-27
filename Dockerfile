FROM ruby:3.2.6
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
EXPOSE 2300
CMD ["bundle", "exec", "hanami", "server", "--host", "0.0.0.0"]
