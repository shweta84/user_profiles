class WelcomeController < ApplicationController


  def index
    # raise "#{request.protocol}#{request.host_with_port}"
    # @welcomes = Welcome.all
  end


  def get_details
    if params[:username].present?
      get_data
    else
      redirect_to root_path, alert: 'Invalid username'
    end
  end

  private ###################################

  def get_data
    t1 = Thread.new { @twitter_data = get_twitter_data }
    t2 = Thread.new { get_github_data }
    t3 = Thread.new { get_ruby_gems_data }
    t1.join
    t2.join
    t3.join
    # @twitter_data = get_twitter_data
    # get_github_data
    # get_ruby_gems_data
  end

  def get_twitter_data
    begin
      $twitter.user_timeline(params[:username], count: 10)
    rescue Twitter::Error::NotFound
      []
    rescue Twitter::Error::RequestTimeout
      []
    end
  end

  def get_github_data
    begin
      github = Github::Client::Users.new
      @github_profile = github.get(user: params[:username]).try(:created_at)
      @github_repos = Github.repos.list user:params[:username]
    rescue Github::Error::NotFound
      []
    end
  end

  def get_ruby_gems_data
    ruby_gems_data = RubyGemsProfile.new params[:username]
    @ruby_gems_profile = ruby_gems_data.get_profile_data
    @ruby_gems_repos = ruby_gems_data.get_repos
  end
end
