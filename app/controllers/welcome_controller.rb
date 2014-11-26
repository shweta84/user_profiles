class WelcomeController < ApplicationController


  def index
  end


  def get_details
    if params[:username].present?
      user = UserProfile.new(params[:username])
      t1 = Thread.new { @twitter_data = user.get_twitter_data }
      t2 = Thread.new { @ruby_gems_profile = user.get_profile_data }
      t3 = Thread.new { @ruby_gems_repos = user.get_repos }
      t4 = Thread.new { @github_profile = user.github_profile }
      t5 = Thread.new { @github_repos = user.github_repos }
      t1.join
      t2.join
      t3.join
      t4.join
      t5.join
    else
      redirect_to root_path, alert: 'Invalid username'
    end
  end


end
