require 'rails_helper'

describe Person do
  # it 'authenticates with matching username and password' do
  #   person = create(:person, name: 'batman', password: 'secret', password_confirmation: 'secret')
  #   Person.authenticate('batman', 'secret').should eq(person)
  # end

  # it 'does not authenticate with incorrect password' do
  #   create(:person, name: 'batman', password: 'secret', password_confirmation: 'secret')
  #   Person.authenticate('batman', 'wrong').should be_nil
  # end

  it 'has a valid factory' do
    person = build(:person)
    expect(person).to be_valid
  end

  it "is invalid without a name" do
    person = build(:person, name: nil)
    expect(person).to_not be_valid
  end

  it "is invalid without a password" do
    person = build(:person, password: nil)
    expect(person).to_not be_valid
  end

  it "is invalid without a email" do
    person = build(:person, email: nil)
    expect(person).to_not be_valid
  end

  it 'saves authority from roles names' do
    person = build(:person, roles: ['admin'])
    expect(person.authority).to eq(1)
    person = build(:person, roles: ['owner'])
    expect(person.authority).to eq(2)
    person = build(:person, roles: ['admin', 'owner'])
    expect(person.authority).to eq(3)
    person = build(:person, roles: ['user'])
    expect(person.authority).to eq(4)
    person = build(:person, roles: ['admin', 'user'])
    expect(person.authority).to eq(5)
    person = build(:person, roles: ['owner', 'user'])
    expect(person.authority).to eq(6)
    person = build(:person, roles: ['admin', 'owner', 'user'])
    expect(person.authority).to eq(7)
  end

  it 'gets role names from authority' do
    person = build(:person, authority: 1)
    expect(person.roles).to eq ['admin']
    person = build(:person, authority: 2)
    expect(person.roles).to eq ['owner']
    person = build(:person, authority: 3)
    expect(person.roles).to eq ['admin', 'owner']
    person = build(:person, authority: 4)
    expect(person.roles).to eq ['user']
    person = build(:person, authority: 5)
    expect(person.roles).to eq ['admin', 'user']
    person = build(:person, authority: 6)
    expect(person.roles).to eq ['owner', 'user']
    person = build(:person, authority: 7)
    expect(person.roles).to eq ['admin', 'owner', 'user']
  end
end
