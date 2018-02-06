# frozen_string_literal: true

require 'json'
require 'sinatra'
require 'sinatra/reloader' if development?

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  # Handles the initial subscription handshake
  get '/event' do
    hub_challenge = params['hub.challenge']

    content_type :json
    { 'hub.challenge' => hub_challenge }.to_json
  end

  post '/event' do
    status 200
    request.body.rewind
    request_payload = JSON.parse(request.body.read)

    p request_payload

    File.open('events.txt', 'a') do |f|
      f.puts(request_payload)
    end
  end
end
