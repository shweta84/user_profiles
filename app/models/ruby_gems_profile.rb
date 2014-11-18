require 'net/http'
class RubyGemsProfile

  def initialize(username)
    @username = username
  end

  def get_profile_data
    begin
      uri = URI.parse("https://rubygems.org/api/v1/profiles/#{@username}.json")
      data = Net::HTTP.get(uri)
      JSON.parse data
    rescue JSON::ParserError
      {}
    end
  end

  def get_repos
    begin
      uri = URI.parse("https://rubygems.org/api/v1/owners/#{@username}/gems.json")
      data = Net::HTTP.get(uri)
      d=JSON.parse data
      d.map { |i| i['name'] }
    rescue JSON::ParserError
      []
    end
  end

end
