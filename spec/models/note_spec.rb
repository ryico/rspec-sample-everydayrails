require 'rails_helper'

RSpec.describe Note, type: :model do
  it 'generates associated data from a factory' do
    note = create(:note)
    puts "This note's project is #{note.project.inspect}"
    puts "This note's user is #{note.user.inspect}"
  end

  before do
    @user = create(:user)

    @project = create(:project)
  end

  it "is valid with a user, project, and message" do
    note = build(:note)
    expect(note).to be_valid
  end

  it "is invalid without a message" do
    note = build(:note, message: nil)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end

  describe "search message for a term" do
    before do
      @note1 = create(:note)
      @note2 = create(:note)
      @note3 = create(:note)
    end

    context "when a match is found" do
      it "returns notes that match the search term" do
        expect(Note.search("note")).to include(@note1, @note3)
      end
    end

    context "when no match is found" do
      it "returns an empty collection" do
        expect(Note.search("message")).to be_empty
      end
    end
  end
end
