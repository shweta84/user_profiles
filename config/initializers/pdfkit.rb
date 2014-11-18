
PDFKit.configure do |config|
  config.default_options = { page_size: 'Letter', print_media_type: true }
  if RUBY_PLATFORM =~ /linux/
    wkhtmltopdf_executable = 'wkhtmltopdf-amd64'
  elsif RUBY_PLATFORM =~ /darwin/
    wkhtmltopdf_executable = 'wkhtmltopdf-osx'
  else
    raise "Unsupported. Must be running linux or intel-based Mac OS."
  end
  config.wkhtmltopdf = Rails.root.join('vendor', 'bin', wkhtmltopdf_executable).to_s
end