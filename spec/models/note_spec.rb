require 'rails_helper'

describe Note do

  it 'has a valid factory' do
    note = build(:note)
    expect(note).to be_valid
  end

  it 'is invalid without text' do
    note = build(:note, note: nil)
    expect(note).to_not be_valid
  end

  it 'is invalid without a dog' do
    note = build(:note, dog: nil)
    expect(note).to_not be_valid
  end

end