require 'rails_helper'

describe CoursePolicy do

  let(:admin) { build(:person, authority: 1) }
  let(:owner) { build(:person, authority: 2) }
  let(:user)  { build(:person, authority: 4) }
  let(:course) { build(:course) }

  subject { described_class }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
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
