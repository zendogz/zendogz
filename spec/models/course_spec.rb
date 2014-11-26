require 'rails_helper'

describe Course do
  before(:each) do
    @course = Course.new
  end

  it "should be invalid without a name and description" do
    @course.should_not be_valid
    @course.name = 'some course name'
    @course.should_not be_valid
    @course.description = 'some course description'
    @course.should be_valid
  end

end
