FROM ubuntu:rolling

# Install basics
RUN apt-get update
RUN apt-get install -y pocketsphinx libpocketsphinx-dev libsphinxbase-dev git-core \
libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev \
libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev libpq-dev \
curl zlib1g-dev build-essential

# Set up our Ruby
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby=2.4.0
RUN git clone https://github.com/awesomeit/myna

WORKDIR myna

RUN bash -l -c "gem install bundler"
RUN bash -l -c "bundle"

CMD bash -l -c "bundle exec karafka w && bundle exec karafka s"