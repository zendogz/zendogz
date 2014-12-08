require 'spec_helper'

describe EnrollmentPolicy do

  let!(:admin) { create(:person, authority: 1) }
  let!(:adam)  { create(:person, authority: 4, name: 'adam') }
  let!(:cate)  { create(:person, authority: 4, name: 'cate') }
  let!(:course_1) { create(:course) }
  let!(:course_2) { create(:course) }
  let!(:adam_course_1) { create(:enrollment, course: course_1, person: adam) }
  let!(:adam_course_2) { create(:enrollment, course: course_2, person: adam) }
  let!(:cate_course_1) { create(:enrollment, course: course_1, person: cate) }

  subject { described_class }

  context ".scope" do
    it 'shows all enrollments to an admin' do
      enrollments = subject::Scope.new(admin, Enrollment).resolve
      expect(enrollments.count).to eq(3)
    end

    it 'shows only own enrollments to a user' do
      enrollments = subject::Scope.new(adam, Enrollment).resolve
      expect(enrollments).to include(adam_course_1)
      expect(enrollments).not_to include(cate_course_1)
    end

    it 'shows no enrollments to a guest' do
      enrollments = subject::Scope.new(nil, Enrollment).resolve
      expect(enrollments.empty?).to be
    end
  end

  permissions :show? do
    it "denies access to a guest" do
      expect(subject).not_to permit(nil, adam_course_1)
    end
    it "denies access to a non-erolled user" do
      expect(subject).not_to permit(cate, adam_course_1)
    end
    it "allows access to an erolled user" do
      expect(subject).to permit(cate, cate_course_1)
    end
    it "allows access to an admin" do
      expect(subject).to permit(admin, adam_course_1)
    end
  end

  permissions :create? do
    it "allows access to a non-admin" do
      expect(subject).to permit(nil, Enrollment)
    end
    it "allows access to an admin" do
      expect(subject).to permit(admin, Enrollment)
    end
  end

  permissions :update? do
    it "denies access to a guest" do
      expect(subject).not_to permit(nil, adam_course_1)
    end
    it "denies access to a non-erolled user" do
      expect(subject).not_to permit(cate, adam_course_1)
    end
    it "allows access to an erolled user" do
      expect(subject).to permit(cate, cate_course_1)
    end
    it "allows access to an admin" do
      expect(subject).to permit(admin, adam_course_1)
    end
  end

  permissions :destroy? do
    it "denies access to a non-admin" do
      expect(subject).not_to permit(adam, adam_course_1)
    end
    it "allows access to an admin" do
      expect(subject).to permit(admin, adam_course_1)
    end
  end
end
