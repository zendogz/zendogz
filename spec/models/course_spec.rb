require 'rails_helper'

describe Course do
  it 'has a valid factory' do
    course = build(:course)
    expect(course).to be_valid
  end

  it 'is invalid without a name' do
    course = build(:course, name: nil)
    expect(course).to_not be_valid
  end

  it 'is invalid without a description' do
    course = build(:course, description: nil)
    expect(course).to_not be_valid
  end

  # TODO: - add schedule testing
end
