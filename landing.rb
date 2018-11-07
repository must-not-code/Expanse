#!/usr/bin/env ruby

require 'sinatra'
require 'slim'
require 'rest-client'
require 'rack-google-analytics'

use Rack::GoogleAnalytics, tracker: ENV['GA_CODE']

get '/' do
  slim :index
end

post '/' do
  if params[:phone].empty? && params[:email].empty?
    status 500
    body 'Укажите телефон или почту для связи!'
  else
    begin
      RestClient.post(
        "https://api:#{ENV['EMAIL_API_KEY']}@api.mailgun.net/v3/#{ENV['EMAIL_DOMAIN']}/messages",
        from: 'Bender Rodriguez <bot@eterra-studio.ru>',
        to: ENV['EMAIL_DESTINATION'],
        subject: 'Аренда.Заявка',
        text: "Имя: #{params[:name]}\nТелефон: #{params[:phone]}\nПочта: #{params[:email]}"
      )

      status 200
      body 'Успешно отправлено!'
    rescue
      status 500
      body 'Произошла ошибка. Повторите попытку позже'
    end
  end
end
