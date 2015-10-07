require 'rails_helper'

describe Testimonial do
  it 'has a valid factory' do
    testimonial = build(:testimonial)
    expect(testimonial).to be_valid
  end

  it 'is invalid without a from' do
    testimonial = build(:testimonial, from: nil)
    expect(testimonial).to_not be_valid
  end

  it 'is invalid without a body' do
    testimonial = build(:testimonial, body: nil)
    expect(testimonial).to_not be_valid
  end
end
