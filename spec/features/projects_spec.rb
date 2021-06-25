require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  scenario 'user creates a new project' do
    user = create(:user)
    sign_in user

    visit root_path

    expect {
      click_link 'New Project'
      fill_in 'Name', with: 'Test Project'
      fill_in 'Description', with: 'Trying out Capybara'
      click_button 'Create Project'
    }.to change(user.projects, :count).by(1)

    expect(page).to have_content 'Test Project'
    expect(page).to have_content 'Trying out Capybara'
    expect(page).to have_content "#{user.name}"
  end
end
