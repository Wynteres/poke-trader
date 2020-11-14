FROM ruby:2.6.6-stretch
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
ENV RAILS_ROOT /var/www/
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT
COPY Gemfile ./
COPY Gemfile.lock ./
RUN bundle install
RUN bundle exec rails assets:precompile
COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
EXPOSE 8080

# Start the main process.
CMD ["rails", "server","-p", "80" "-b", "0.0.0.0"]
