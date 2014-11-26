require 'rails_helper'

describe LessonPolicy do

  let(:admin) { build(:person, authority: 1) }
  let(:user)  { build(:person, authority: 4) }
  let(:course) { build(:course) }
  let(:lesson) { build(:lesson, course: course) }

  subject { LessonPolicy }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    it "denies access to non-logged in guest" do
      expect(subject).not_to permit(nil, lesson)
    end
    it "allows access to non-admin user" do
      expect(subject).to permit(user, lesson)
    end
    it "allows access to admin user" do
      expect(subject).to permit(admin, lesson)
    end
  end

  permissions :create? do
    it "denies access to non-admin user" do
      expect(subject).not_to permit(user, lesson)
    end
    it "allows access to admin user" do
      expect(subject).to permit(admin, lesson)
    end
  end

  permissions :update? do
    it "denies access to non-admin user" do
      expect(subject).not_to permit(user, lesson)
    end
    it "allows access to admin user" do
      expect(subject).to permit(admin, lesson)
    end
  end

  permissions :destroy? do
    it "denies access to non-admin user" do
      expect(subject).not_to permit(user, lesson)
    end
    it "allows access to admin user" do
      expect(subject).to permit(admin, lesson)
    end
  end
end
