require 'rails_helper'

describe Course do

  it "is invalid without a name" do
    @course = build(:course, name: nil)
    expect(@course).to_not be_valid
    @course.name = 'some course name'
    expect(@course).to be_valid
  end

  it "is invalid without a description" do
    @course = build(:course, description: nil)
    expect(@course).to_not be_valid
    @course.description = 'some course description'
    expect(@course).to be_valid
  end

  #todo - add schedule testing

end
