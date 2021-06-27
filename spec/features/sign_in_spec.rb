require 'rails_helper'

RSpec.feature "SignIn", type: :feature do
  let(:user) { create(:user) }

  before do
    ActiveJob::Base.queue_adapter = :test
  end

  skip scenario 'user signs in' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect {
      GeocodeUserJob.perform_later(uesr)
    }.to have_enqueued_job.with(user)
  end
end
