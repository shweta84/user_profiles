require 'spec_helper'

feature "User profile" do

  scenario "with username" do
    when_i_visit_root_path
    fill_in 'Username', with: 'ryanb'
    click_button 'Submit'
    expect(page).to have_selector(:link_or_button, 'Download PDF')
    expect(page).to have_content("Thu, 07 Feb 2008")
    expect(page).to have_content("ryan@railscasts.com")
  end

  scenario "without username" do
    when_i_visit_root_path
    fill_in 'Username', with: ''
    click_button 'Submit'
    expect(page).to have_content("Invalid username")
  end

  def when_i_visit_root_path
    visit root_path
    expect(page).to have_selector(:link_or_button, 'Home')
    expect(page).to have_content('Username')
  end

end
