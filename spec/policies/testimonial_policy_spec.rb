require 'spec_helper'

describe TestimonialPolicy do

  let!(:admin) { create(:person, authority: 1) }
  let!(:user)  { create(:person, authority: 4) }
  let!(:testimonial1) { create(:testimonial) }
  let!(:testimonial2) { create(:testimonial) }
  let!(:testimonial3) { create(:testimonial) }

  subject { described_class }

  context ".scope" do
    it 'shows all testimonials to a guest' do
      testimonials = subject::Scope.new(nil, Testimonial).resolve
      expect(testimonials.count).to eq(3)
    end
  end

  permissions :show? do
    it "allows access to a user" do
      expect(subject).to permit(user, testimonial1)
    end
    it "allows access to a guest" do
      expect(subject).to permit(nil, testimonial1)
    end
  end

  permissions :create? do
    it "allows access to a user" do
      expect(subject).to permit(user, testimonial1)
    end
    it "denies access to a guest" do
      expect(subject).not_to permit(nil, testimonial1)
    end
  end

  permissions :update? do
    it "denies access to non-admin user" do
      expect(subject).not_to permit(user, testimonial1)
    end
    it "allows access to admin user" do
      expect(subject).to permit(admin, Testimonial)
    end
  end

  permissions :destroy? do
    it "denies access to non-admin user" do
      expect(subject).not_to permit(user, testimonial1)
    end
    it "allows access to admin user" do
      expect(subject).to permit(admin, Testimonial)
    end
  end

end

