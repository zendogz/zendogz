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
    subject do
      p = Person.new(name: 'foo', roles: ['owner'])
      Permission.new(p)
    end
    it 'allows dogs actions' do subject.can?('dogs').should be_true end
    it 'allows notes actions' do subject.can?('notes').should be_true end
  end

  context 'when logged in as an admin' do
    subject do
      p = Person.new(name: 'foo', roles: ['admin'])
      Permission.new(p)
    end

    it 'allows all controllers and actions' do subject.can?('dogs', 'destroy').should be_true end
  end



end
