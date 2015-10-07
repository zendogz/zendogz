require 'rails_helper'

describe Dog do
  it 'has a valid factory' do
    dog = build(:dog)
    expect(dog).to be_valid
  end

  it 'is invalid without a name' do
    dog = build(:dog, name: nil)
    expect(dog).to_not be_valid
  end

  context 'view access' do
    let!(:cate)  { create(:person, name: 'cate', roles: ['owner']) }
    let!(:chloe) { create(:dog, name: 'chloe', person_id: cate.id) }
    let!(:mark)  { create(:person, name: 'mark', roles: ['admin']) }
    let!(:mugs)  { create(:dog, name: 'mugs', person_id: mark.id) }

    it 'lets owners see only their own dogs' do
      expect(Dog.for(cate).count).to eq(1)
    end

    it 'lets admins see all dogs' do
      expect(Dog.for(mark).count).to eq(2)
    end

    it 'lets guests see no dogs' do
      expect(Dog.for(nil)).to be nil
    end
  end
end
