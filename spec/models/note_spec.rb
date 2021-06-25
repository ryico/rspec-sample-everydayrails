require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:user) { create(:user) }
  let(:project) { create(:project, owner: user) }

  it 'generates associated data from a factory' do
    note = create(:note)
    puts "This note's project is #{note.project.inspect}"
    puts "This note's user is #{note.user.inspect}"
  end

  it 'is valid with a user, project, and message' do
    note = build(:note,
      message: 'This is a sample note.',
      user: user,
      project: project
    )
    expect(note).to be_valid
  end

  it 'is invalid without a message' do
    note = build(:note, message: nil)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end

  describe 'search message for a term' do
    let!(:note1) {
      create(:note,
        project: project,
        user: user,
        message: 'This is the first note.'
      )
    }

    let!(:note2) {
      create(:note,
        project: project,
        user: user,
        message: 'This is the second note.'
      )
    }

    let!(:note3) {
      create(:note,
        project: project,
        user: user,
        message: 'First, preheat the oven.'
      )
    }

    context 'when a match is found' do
      it 'returns notes that match the search term' do
        expect(Note.search('first')).to include(note1, note3)
      end
    end

    context 'when no match is found' do
      it 'eturns an empty collection' do
        expect(Note.search('message')).to be_empty
      end
    end

    context 'when no match is found' do
      it 'returns an empty collection' do
        aggregate_failures do
          expect(Note.search('message')).to be_empty
          expect(Note.count).to eq(3)
        end
      end
    end
  end
end
