require 'rails_helper'

describe Lesson do
  before(:each) do
    @lesson = build(:lesson)
  end

  it "should be invalid without a name" do
    blank_lesson = Lesson.new
    blank_lesson.should_not be_valid
    blank_lesson.name = 'some lesson name'
    blank_lesson.should be_valid
    @lesson.should be_valid
  end
end
