# config/initializers/imgkit.rb
IMGKit.configure do |config|
  config.wkhtmltoimage = Rails.root.join('.bin', 'wkhtmltoimage').to_s
end
