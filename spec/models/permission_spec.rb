require 'spec_helper'

describe Permission do

  context 'when not logged in' do
    subject { Permission.new(nil) }
    it 'allows sessions actions' do subject.allow?('sessions', 'xxx').should be_true end
    it 'allows all pages' do subject.allow?('pages', 'xxx').should be_true end
    it 'allows listing testimonials' do subject.allow?('testimonials', 'index').should be_true end
    it 'allows viewing testimonials' do subject.allow?('testimonials', 'show').should be_true end
    it 'denies editing testimonials' do subject.allow?('testimonials', 'edit').should_not be_true end
    it 'allows listing courses' do subject.allow?('courses', 'index').should be_true end
    it 'allows viewing courses' do subject.allow?('courses', 'show').should be_true end
    it 'denies editing courses' do subject.allow?('courses', 'edit').should_not be_true end
    it 'allows creating people' do subject.allow?('people', 'new').should be_true end
    it 'denies updating people' do subject.allow?('people', 'update').should_not be_true end
  end

  context 'when logged in as a user' do
    subject do
      p = Person.new(name: 'foo', roles: ['user'])
      Permission.new(p)
    end
    it 'allows editing people' do subject.allow?('people', 'edit').should be_true end
    it 'allows updating people' do subject.allow?('people', 'update').should be_true end
  end

  context 'when logged in as an owner' do
    subject do
      p = Person.new(name: 'foo', roles: ['owner'])
      Permission.new(p)
    end
    it 'allows dogs actions' do subject.allow?('dogs', 'xxx').should be_true end
    it 'allows notes actions' do subject.allow?('notes', 'xxx').should be_true end
  end

  context 'when logged in as an admin' do
    subject do
      p = Person.new(name: 'foo', roles: ['admin'])
      Permission.new(p)
    end

    it 'allows all controllers and actions' do subject.allow?('xxx', 'xxx').should be_true end
  end



end
