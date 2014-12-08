require 'spec_helper'

describe NotePolicy do

  let!(:admin) { create(:person, authority: 1) }
  let!(:adam)  { create(:person, authority: 2) }
  let!(:user)  { create(:person, authority: 4) }
  let!(:darby) { create(:dog, name: 'darby', person: adam) }
  let!(:note1) { create(:note, dog: darby) }
  let!(:note2) { create(:note, dog: darby) }
  let!(:note3) { create(:note) }

  subject { described_class }

  context ".scope" do
    it 'shows all notes to an admin' do
      notes = subject::Scope.new(admin, Note).resolve
      expect(notes.count).to eq(3)
    end

    it 'shows only notes for owned dogs to an owner' do
      notes = subject::Scope.new(adam, Note).resolve
      expect(notes.count).to eq(2)
      expect(notes).not_to include(note3)
    end

    it 'shows no notes to a non-owner' do
      notes = subject::Scope.new(user, Note).resolve
      expect(notes.empty?).to be
    end  end

  permissions :show? do
    it "denies access to a guest" do
      expect(subject).not_to permit(nil, note1)
    end
    it "denies access to a non-owner" do
      expect(subject).not_to permit(user, note1)
    end
    it "allows access to an owner" do
      expect(subject).to permit(adam, note1)
    end
    it "allows access to an admin" do
      expect(subject).to permit(admin, note1)
    end
  end

  permissions :create? do
    it "denies access to a non-admin" do
      expect(subject).not_to permit(user, Note)
    end
    it "allows access to an admin" do
      expect(subject).to permit(admin, Note)
    end
  end

  permissions :update? do
    it "denies access to a non-admin" do
      expect(subject).not_to permit(user, note1)
    end
    it "allows access to an admin" do
      expect(subject).to permit(admin, Note)
    end
  end

  permissions :destroy? do
    it "denies access to a non-admin" do
      expect(subject).not_to permit(user, note1)
    end
    it "allows access to an admin" do
      expect(subject).to permit(admin, Note)
    end
  end

end
