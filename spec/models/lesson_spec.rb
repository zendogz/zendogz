require 'rails_helper'

describe Lesson do

  it "is invalid without a name" do
    @lesson = build(:course, name: nil)
    expect(@lesson).to_not be_valid
    @lesson.name = 'some lesson name'
    expect(@lesson).to be_valid
  end
end
