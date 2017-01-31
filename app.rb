ENV['RACK_ENV'] ||= 'development'
ENV['KARAFKA_ENV'] ||= ENV['RACK_ENV']

Bundler.require(:default, ENV['KARAFKA_ENV'])

Karafka::Loader.new.load(Karafka::App.root)

# App class
class App < Karafka::App
  setup do |config|
    config.kafka.hosts = %w( 127.0.0.1:9092 )
    config.name = 'example_app'
    config.redis = {
      url: 'redis://localhost:6379'
    }
    config.inline = false
  end

  routes.draw do
    # topic :example do
    #   controller ExampleController
    #   interchanger CustomInterchanger
    # end
  end
end

App.boot!
