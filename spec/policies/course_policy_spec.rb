require 'rails_helper'

describe CoursePolicy do

  let(:admin) { build(:person, authority: 1) }
  let(:owner) { build(:person, authority: 2) }
  let(:user)  { build(:person, authority: 4) }
  let!(:course) { create(:course) }

  subject { described_class }

  context ".scope" do
    it 'shows all courses to an admin' do
      courses = subject::Scope.new(admin, Course).resolve
      expect(courses.count).to eq(1)
    end

    it 'shows all courses to a user' do
      courses = subject::Scope.new(user, Course).resolve
      expect(courses.count).to eq(1)
    end

    it 'shows all courses to a guest' do
      courses = subject::Scope.new(nil, Course).resolve
      expect(courses.count).to eq(1)
    end
  end

  permissions :show? do
    it "allows access to everyone" do
      expect(subject).to permit(user, course)
    end
  end

  permissions :create? do
    it "denies access to non-admin user" do
      expect(subject).not_to permit(user, course)
    end
    it "allows access to admin user" do
      expect(subject).to permit(admin, course)
    end
  end

  permissions :update? do
    it "denies access to non-admin user" do
      expect(subject).not_to permit(user, course)
    end
    it "allows access to admin user" do
      expect(subject).to permit(admin, course)
    end
  end

  permissions :destroy? do
    it "denies access to non-admin user" do
      expect(subject).not_to permit(user, course)
    end
    it "allows access to admin user" do
      expect(subject).to permit(admin, course)
    end
  end
end
