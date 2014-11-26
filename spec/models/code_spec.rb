require 'rails_helper'

describe Code do
  before(:each) do
    @code = build(:code)
  end

  it "should be invalid without a set, code or description" do
    blank_code = Code.new
    blank_code.should_not be_valid
    blank_code.set = Code.new
    blank_code.should_not be_valid
    blank_code.code = 'code'
    blank_code.should_not be_valid
    blank_code.description = 'description'
    blank_code.should be_valid
    @code.should be_valid
  end

end
