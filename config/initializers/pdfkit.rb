
PDFKit.configure do |config|
  config.wkhtmltopdf = '/app/vendor/bundle/bin/wkhtmltopdf'
  config.default_options = {
      :page_size => 'Letter',
      :print_media_type => true
  }
  # Use only if your external hostname is unavailable on the server.
  # config.root_url = "http://localhost/"
  config.verbose = false
end

