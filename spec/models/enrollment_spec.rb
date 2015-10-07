require 'rails_helper'

describe Enrollment do
  it 'has a valid factory' do
    enrollment = build(:enrollment)
    expect(enrollment).to be_valid
  end

  it 'is invalid without a person' do
    enrollment = build(:enrollment, person: nil)
    expect(enrollment).to_not be_valid
  end

  it 'is invalid without a course' do
    enrollment = build(:enrollment, course: nil)
    expect(enrollment).to_not be_valid
  end
end
