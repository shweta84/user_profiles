class UserProfile
  attr_reader :github_profile, :github_repos
  delegate :get_profile_data, :get_repos, to: :@ruby_gems_data

  def initialize(username)
    @username = username
    get_github_data

    @ruby_gems_data = RubyGemsProfile.new username
  end

  def get_twitter_data
    begin
      $twitter.user_timeline(@username, count: 10)
    rescue Twitter::Error::NotFound
      []
    rescue Twitter::Error::RequestTimeout
      []
    rescue
      []
    end
  end

  def get_github_data
    begin
      github = Github::Client::Users.new
      @github_profile ||= github.get(user: @username).try(:created_at)
      @github_repos ||= Github.repos.list user:@username
    rescue Github::Error::NotFound
      []
    end
  end

end