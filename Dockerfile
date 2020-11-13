FROM ruby:2.6.6-stretch
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /pokeTrader
WORKDIR /pokeTrader
COPY Gemfile /pokeTrader/Gemfile
COPY Gemfile.lock /pokeTrader/Gemfile.lock
RUN bundle install
COPY . /pokeTrader

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
EXPOSE 8080

# Start the main process.
CMD ["rails", "server","-p", "80" "-b", "0.0.0.0"]
