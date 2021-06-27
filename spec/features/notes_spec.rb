require 'rails_helper'

RSpec.feature 'Notes', type: :feature do
  let(:user) { create(:user) }
  let(:project) {
    create(:project,
      name: 'RSpec tutorial',
      owner: user
    )
  }

  scenario 'user uploads an attachment' do
    sign_in user
    visit project_path(project)
    click_link 'Add Note'
    fill_in  'Message', with: 'My book cover'
    attach_file 'Attachment', "#{Rails.root}/spec/files/attachment.jpeg"
    click_button 'Create Note'
    aggregate_failures do
      skip expect(page).to have_content 'Note was successfully created'
      expect(page).to have_content 'My book cover'
      expect(page).to have_content 'attachment.jpeg (image/jpeg'
    end
  end
end
