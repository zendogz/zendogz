require 'spec_helper'

describe Dog do

  it 'should be invalid without a name' do
    @dog = Dog.new
    @dog.should_not be_valid
    @dog.name = 'some dog name'
    @dog.should be_valid
  end

  describe 'dog view access' do
    it 'lets owners see only their own dogs' do
      @cate = create(:person, name: 'cate', roles: ['owner'])
      @chloe = create(:dog, name: 'chloe', person_id: @cate.id)
      @mark = create(:person, name: 'mark', roles: ['admin'])
      @mugs = create(:dog, name: 'mugs', person_id: @mark.id)
      marks_dogs = Dog.for(@mark)
      marks_dogs.size.should eq(2)
      cates_dogs = Dog.for(@cate)
      cates_dogs.size.should eq(1)
    end
  end

end