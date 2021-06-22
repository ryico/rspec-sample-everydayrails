require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'is late when the due date is past today' do
    project = create(:project, :due_yesterday)
    expect(project).to be_late
  end

  it 'is on time when the due date is today' do
    project = create(:project, :due_today)
    expect(project).to_not be_late
  end

  it 'is on time when the due date is in the future' do
    project = create(:project, :due_tomorrow)
    expect(project).to_not be_late
  end

  it 'can have many notes' do
    project = create(:project, :with_notes)
    expect(project.notes.length).to eq 5
  end

  it "does not allow duplicate project names per user" do
    user = create(:user)

    user.projects.create(
      name: "Test Project",
    )

    new_project = user.projects.build(
      name: "Test Project",
    )

    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end

  it "allows two users to share a project name" do
    user = create(:user)

    user.projects.create(
      name: "Test Project",
    )

    other_user = create(:user)

    other_project = other_user.projects.build(
      name: "Test Project",
    )

    expect(other_project).to be_valid
  end
end
