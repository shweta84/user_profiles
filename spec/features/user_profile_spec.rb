require 'spec_helper'

feature "User profile" do

  scenario "with username" do
    when_i_visit_root_path
    fill_in 'Username', with: 'ryanb'
    click_button 'Submit'
    page.should have_selector(:link_or_button, 'Download PDF')
    page.should have_content("Thu, 07 Feb 2008")
    page.should have_content("ryan@railscasts.com")
    # page.should have_content(yoni.full_name)
  end

  scenario "without username" do
     when_i_visit_root_path
     fill_in 'Username', with: ''
     click_button 'Submit'
    page.should have_content("Invalid username")
    # expect(page).not_to have_content(yoni.full_name)
  end

  def when_i_visit_root_path
    visit root_path
    page.should have_selector(:link_or_button, 'Home')
    expect(page).to have_content('Username')
  end

end
