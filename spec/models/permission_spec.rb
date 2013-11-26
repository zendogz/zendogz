require 'spec_helper'

describe Permission do

  context 'when not logged in' do
    subject { Permission.new(nil) }
    it 'allows sessions actions' do subject.can?('sessions').should be_true end
    it 'allows all pages' do subject.can?('pages').should be_true end
    it 'allows listing testimonials' do subject.can?('testimonials', 'index').should be_true end
    it 'allows viewing testimonials' do subject.can?('testimonials', 'show').should be_true end
    it 'denies editing testimonials' do subject.can?('testimonials', 'edit').should_not be_true end
    it 'allows listing courses' do subject.can?('courses', 'index').should be_true end
    it 'allows viewing courses' do subject.can?('courses', 'show').should be_true end
    it 'denies editing courses' do subject.can?('courses', 'edit').should_not be_true end
    it 'allows creating people' do subject.can?('people', 'new').should be_true end
    it 'denies updating people' do subject.can?('people', 'update').should_not be_true end
  end

  context 'when logged in as a user' do
    subject do
      p = Person.new(name: 'foo', roles: ['user'])
      Permission.new(p)
    end
    it 'allows editing people' do subject.can?('people', 'edit').should be_true end
    it 'allows updating people' do subject.can?('people', 'update').should be_true end
  end

  context 'when logged in as an owner' do
    let(:owner) { create(:person, roles: ['owner']) }
    let(:owner_dog) { build(:dog, person: owner) }
    let(:other_dog) { build(:dog) }
    subject { Permission.new(owner) }
    it 'allows dogs new' do subject.can?(:dogs, :new).should be_true end
    it 'allows dogs create' do subject.can?(:dogs, :create).should be_true end
    it 'denies dogs edit' do subject.can?(:dogs, :edit).should_not be_true end
    it 'allows edit own dogs' do subject.can?(:dogs, :edit, :owner_dog).should be_true end
    it 'denies edit others dogs' do subject.can?(:dogs, :edit, :other_dog).should_not be_true end
  end

  context 'when logged in as an admin' do
    subject do
      p = Person.new(name: 'foo', roles: ['admin'])
      Permission.new(p)
    end

    it 'allows all controllers and actions' do subject.can?('dogs', 'destroy').should be_true end
  end

end
