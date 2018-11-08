#!/usr/bin/env ruby

require 'sinatra'
require 'slim'
require 'pony'
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
      Pony.mail({
        to: ENV['EMAIL_DESTINATION'],
        from: 'Bender Rodriguez <bot@eterra-studio.ru>',
        subject: 'Сообщение через форму на eterra-studio.ru',
        body: "Имя: #{params[:name]}\nТелефон: #{params[:phone]}\nПочта: #{params[:email]}",
        via: :smtp,
        via_options: {
          address: 'smtp.gmail.com',
          port: '587',
          enable_starttls_auto: true,
          user_name: ENV['EMAIL_USERNAME'],
          password: ENV['EMAIL_PASSWORD'],
          authentication: :plain,
          domain: 'eterra-studio.ru'
        }
      })

      status 200
      body 'Успешно отправлено!'
    rescue
      status 500
      body 'Произошла ошибка. Повторите попытку позже'
    end
  end
end
