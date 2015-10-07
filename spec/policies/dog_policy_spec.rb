require 'rails_helper'

describe DogPolicy do
  let!(:admin) { create(:person, authority: 1) }
  let!(:adam)  { create(:person, authority: 2) }
  let!(:user)  { create(:person, authority: 4) }
  let!(:darby) { create(:dog, name: 'darby', person: adam) }
  let!(:rex)   { create(:dog, name: 'rex') }

  subject { described_class }

  context '.scope' do
    it 'shows all dogs to an admin' do
      dogs = subject::Scope.new(admin, Dog).resolve
      expect(dogs.count).to eq(2)
    end

    it 'shows only owned dogs to an owner' do
      dogs = subject::Scope.new(adam, Dog).resolve
      expect(dogs).to include(darby)
      expect(dogs).not_to include(rex)
    end

    it 'shows no dogs to a user' do
      dogs = subject::Scope.new(user, Dog).resolve
      expect(dogs.empty?).to be
    end
  end

  permissions :show? do
    it 'denies access to a guest' do
      expect(subject).not_to permit(nil, darby)
    end
    it 'denies access to a user' do
      expect(subject).not_to permit(user, darby)
    end
    it 'allows access to an owner' do
      expect(subject).to permit(adam, darby)
    end
    it 'allows access to an admin' do
      expect(subject).to permit(admin, darby)
    end
  end

  permissions :create? do
    it 'denies access to a non-admin' do
      expect(subject).not_to permit(user, Dog)
    end
    it 'allows access to an admin' do
      expect(subject).to permit(admin, Dog)
    end
  end

  permissions :update? do
    it 'denies access to a non-admin' do
      expect(subject).not_to permit(user, darby)
    end
    it 'allows access to an admin' do
      expect(subject).to permit(admin, Dog)
    end
  end

  permissions :destroy? do
    it 'denies access to a non-admin' do
      expect(subject).not_to permit(user, darby)
    end
    it 'allows access to an admin' do
      expect(subject).to permit(admin, Dog)
    end
  end
end
