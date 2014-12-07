require 'spec_helper'

describe PersonPolicy do

  let!(:admin) { create(:person, authority: 1) }
  let!(:owner) { create(:person, authority: 2) }
  let!(:user)  { create(:person, authority: 4) }

  subject { described_class }

  context ".scope" do
    it 'shows all people to an admin' do
      people = subject::Scope.new(admin, Person).resolve
      expect(people.count).to eq(3)
    end

    it 'shows only own record to a user' do
      people = subject::Scope.new(user, Person).resolve
      expect(people.count).to eq(1)
      expect(people).to include(user)
    end

    it 'shows no people to a guest' do
      people = subject::Scope.new(nil, Person).resolve
      expect(people.count).to eq(0)
    end
  end

  permissions :show? do
    it "denies access to a guest" do
      expect(subject).not_to permit(nil, user)
    end
    it "denies access to another user" do
      expect(subject).not_to permit(user, owner)
    end
    it "allows access to self" do
      expect(subject).to permit(user, user)
    end
    it "allows access to admin user" do
      expect(subject).to permit(admin, owner)
    end
  end

  permissions :create? do
    it "allows access to guest" do
      expect(subject).to permit(nil, owner)
    end
  end

  permissions :update? do
    it "denies access to a guest" do
      expect(subject).not_to permit(nil, user)
    end
    it "denies access to another user" do
      expect(subject).not_to permit(user, owner)
    end
    it "allows access to self" do
      expect(subject).to permit(user, user)
    end
    it "allows access to admin user" do
      expect(subject).to permit(admin, owner)
    end
  end

  permissions :destroy? do
    it "denies access to a guest" do
      expect(subject).not_to permit(nil, user)
    end
    it "denies access to a user" do
      expect(subject).not_to permit(user, user)
    end
    it "allows access to admin user" do
      expect(subject).to permit(admin, owner)
    end
  end

end
