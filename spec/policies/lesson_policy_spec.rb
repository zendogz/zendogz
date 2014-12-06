require 'rails_helper'

describe LessonPolicy do

  let!(:admin) { build(:person, authority: 1) }
  let!(:user)  { build(:person, authority: 4) }
  let!(:course_1) { create(:course) }
  let!(:lesson_1_1) { create(:lesson, course: course_1) }
  let!(:lesson_1_2) { create(:lesson, course: course_1) }
  let!(:course_2) { create(:course) }
  let!(:lesson_2_1) { create(:lesson, course: course_2) }
  let!(:lesson_2_2) { create(:lesson, course: course_2) }

  subject { described_class }

  context ".scope" do
    it 'shows all lessons to an admin' do
      lessons = subject::Scope.new(admin, Lesson).resolve
      expect(lessons.count).to eq(4)
    end

    it 'shows only lessons for enrolled classes to a user' do
      # enroll user into course (which has 2 lessons)
      user.enroll(course_1)
      user.save
      lessons = subject::Scope.new(user, Lesson).resolve
      expect(lessons.count).to eq(2)
    end

    it 'shows no lessons to a guest' do
      lessons = subject::Scope.new(nil, Lesson).resolve
      expect(lessons.count).to eq(0)
    end
  end

  permissions :show? do
    it "denies access to non-logged in guest" do
      expect(subject).not_to permit(nil, lesson_1_1)
    end
    it "denies access to non-erolled user" do
      expect(subject).not_to permit(user, lesson_1_1)
    end
    it "allows access to an erolled user" do
      user.enroll(lesson_1_1.course)
      expect(subject).to permit(user, lesson_1_1)
    end
    it "allows access to admin user" do
      expect(subject).to permit(admin, lesson_1_1)
    end
  end

  permissions :create? do
    it "denies access to non-admin user" do
      expect(subject).not_to permit(user, lesson_1_1)
    end
    it "allows access to admin user" do
      expect(subject).to permit(admin, lesson_1_1)
    end
  end

  permissions :update? do
    it "denies access to non-admin user" do
      expect(subject).not_to permit(user, lesson_1_1)
    end
    it "allows access to admin user" do
      expect(subject).to permit(admin, lesson_1_1)
    end
  end

  permissions :destroy? do
    it "denies access to non-admin user" do
      expect(subject).not_to permit(user, lesson_1_1)
    end
    it "allows access to admin user" do
      expect(subject).to permit(admin, lesson_1_1)
    end
  end
end
