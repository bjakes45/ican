require "rails_helper"

RSpec.feature "Visit show council", :type => :feature do
  let(:user) { create(:user) }
  let(:council) { create(:council) }

  scenario "User goes to show council page from the home page", js: true do
    council
    visit root_path
    page.find(".single-post-card").click
    expect(page).to have_selector('body .modal')
    page.find('.interested a').click
    expect(page).to have_selector('#single-post-content p', text: council.description)
  end

end