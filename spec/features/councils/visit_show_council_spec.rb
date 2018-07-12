require "rails_helper"

RSpec.feature "Visit show council", :type => :feature do
  let(:user) { create(:user) }
  let(:council) { create(:council) }

  scenario "User goes to show council page from the home page", js: true do
    council
    sign_in user
    visit root_path
    expect(page).to have_selector('body .modal', visible: false)
    page.find(".single-council-card").trigger(:click)
    expect(page).to have_selector('body .modal', visible: false)
    page.find('.interested a', visible: false)
    visit council_path(council)
    puts page.body
    expect(page).to have_selector('.council-desc', text: council.description)
  end

end