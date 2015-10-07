require 'rails_helper'

describe Lesson do
  it 'has a valid factory' do
    lesson = build(:lesson)
    expect(lesson).to be_valid
  end

  it 'is invalid without a name' do
    lesson = build(:lesson, name: nil)
    expect(lesson).to_not be_valid
  end
end
