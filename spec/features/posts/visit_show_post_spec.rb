require "rails_helper"

RSpec.feature "Visit single post", :type => :feature do
  let(:user) { create(:user) }
  let(:council) { create(:council) }
  let(:post) { Post.create(council_id: council.id, user_id: user.id) }

  scenario "User goes to a single post from the home page", js: true do
    post
    sign_in user
    visit council_path(council)
    page.find(".single-post-card").click
    expect(page).to have_selector('body .modal', visible: false)
    page.find('.interested a', visible: false)
    visit council_post_path(council, post)
    expect(page).to have_selector('#single-post-content p', text: post.content)
  end

end