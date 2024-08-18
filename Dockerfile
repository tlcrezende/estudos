FROM ruby:3.1.3
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# CI Fix
RUN apt-get clean all
RUN apt-get update

RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client shared-mime-info vim

RUN yarn install
RUN mkdir /app
WORKDIR /app
COPY Gemfile .
RUN bundle install
COPY . .

# Add a script to be executed every time the container starts.
RUN chmod +x ./entrypoints/docker-entrypoint.sh
RUN chmod +x ./entrypoints/entrypoint-development.sh

# ENV RAILS_ENV development

# Change timezone
ENV TZ=America/Sao_Paulo

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]

EXPOSE 3000

