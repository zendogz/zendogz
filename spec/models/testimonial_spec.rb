require 'rails_helper'

describe Testimonial do
  it 'should be invalid without a from or body' do
    @testimonial = Testimonial.new
    @testimonial.should_not be_valid
    @testimonial.from = 'someone'
    @testimonial.should_not be_valid
    @testimonial.body = 'some comments'
    @testimonial.should be_valid
  end
end
