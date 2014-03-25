require 'spec_helper'

describe Permission do

  describe 'when not logged in' do
    subject { Permission.new(nil) }
    it 'allows show log in form' do subject.can?(:sessions, :new).should be_true end
    it 'allows log in action' do subject.can?(:sessions, :create).should be_true end
    it 'allows log out' do subject.can?(:sessions, :destroy).should be_true end
    it 'allows access to home page' do subject.can?(:pages, :home).should be_true end
    it 'allows access to about page' do subject.can?(:pages, :about).should be_true end
    it 'allows access to services page' do subject.can?(:pages, :services).should be_true end
    it 'allows access to contact page' do subject.can?(:pages, :contact).should be_true end
    it 'denies access to unknown page' do subject.can?(:pages, :unknown).should_not be_true end
    #testimonials
    it 'allows listing testimonials' do subject.can?(:testimonials, :index).should be_true end
    it 'allows viewing testimonials' do subject.can?(:testimonials, :show).should be_true end
    it 'denies editing testimonials' do subject.can?(:testimonials, :edit).should_not be_true end
    # courses
    it 'allows listing courses' do subject.can?(:courses, :index).should be_true end
    it 'allows viewing courses' do subject.can?(:courses, :show).should be_true end
    it 'denies editing courses' do subject.can?(:courses, :edit).should_not be_true end
    # lessons
    it 'denies listing lessons' do subject.can?(:lessons, :index).should_not be_true end
    it 'denies viewing lessons' do subject.can?(:lessons, :show).should_not be_true end
    it 'denies editing lessons' do subject.can?(:lessons, :edit).should_not be_true end
    # people
    it 'allows creating people' do subject.can?(:people, :new).should be_true end
    it 'denies updating people' do subject.can?(:people, :update).should_not be_true end
  end

  describe 'when logged in as a user' do
    let(:user) { create(:person, roles: ['user']) }
    let(:another_user) { create(:person) }
    subject { Permission.new(user) }
    it 'allows editing own profile' do subject.can?(:people, :edit, user).should be_true end
    it 'allows updating own profile' do subject.can?(:people, :update, user).should be_true end
    it 'denies editing another profile' do subject.can?(:people, :edit, another_user).should_not be_true end
    it 'denies updating another profile' do subject.can?(:people, :update, another_user).should_not be_true end
    it 'allows enrolling for a course' do subject.can?(:enrollments, :new).should be_true end
    it 'allows enrolling for a course' do subject.can?(:enrollments, :create).should be_true end
  end

  describe 'when logged in as a student' do
    # a student is jus a user for now
    let(:student) { create(:person, roles: ['user']) }
    subject { Permission.new(student) }
    # lessons
    it 'allows listing lessons' do subject.can?(:lessons, :index).should be_true end
    it 'allows viewing lessons' do subject.can?(:lessons, :show).should be_true end
    it 'denies editing lessons' do subject.can?(:lessons, :edit).should_not be_true end
  end

  describe 'when logged in as an owner' do
    let(:owner) { create(:person, roles: ['owner']) }
    let(:owner_dog) { build(:dog, person: owner) }
    let(:other_dog) { build(:dog) }
    subject { Permission.new(owner) }
    it 'allows dogs new' do subject.can?(:dogs, :new).should be_true end
    it 'allows dogs create' do subject.can?(:dogs, :create).should be_true end
    it 'denies dogs edit' do subject.can?(:dogs, :edit).should_not be_true end
    it 'allows edit own dogs' do subject.can?(:dogs, :edit, owner_dog).should be_true end
    it 'denies edit others dogs' do subject.can?(:dogs, :edit, other_dog).should_not be_true end
  end

  describe 'when logged in as an admin' do
    subject do
      p = Person.new(name: 'foo', roles: ['admin'])
      Permission.new(p)
    end

    it 'allows all controllers and actions' do subject.can?('dogs', 'destroy').should be_true end
  end

end
