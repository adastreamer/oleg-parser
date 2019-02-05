require 'open-uri'
require 'nokogiri'
require 'httparty'
require 'prawn'

# базовый урл
BASE = ENV['PARSER_BASE']
# эндпоинт с картинками
SOURCE = "#{BASE}#{ENV['PARSER_VIEW_JSP_PAGE']}"

# авторизация
USERNAME = ENV['PARSER_USERNAME']
PASSWORD = ENV['PARSER_PASSWORD']
auth = { username: USERNAME, password: PASSWORD }

TMP = "tmp"

# получаем страницу
data = HTTParty.get(SOURCE, basic_auth: auth, verify: false)

# берем html
page = Nokogiri::HTML(data)

# все картинки
images = page.css('img')

# выбираем картинки для объединения в PDF
target = [7, 8, 9, 10]

# вспомогательный указатель
objects = []

# по каждой картинке пройтись
target.each_with_index do |t, i|
  objects[i] = BASE + images[t]['src']
  open("#{TMP}/#{t}", 'wb') do |file|
    file << open(objects[i], {
      ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,
      http_basic_authentication: [ USERNAME, PASSWORD ]
    }).read
  end
end

# и сгенерировать pdf
Prawn::Document.generate('out.pdf') do
  target.each do |t|
    image "#{TMP}/#{t}"
  end
end
