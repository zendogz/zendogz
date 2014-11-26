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

  it 'saves authority from roles names' do
    person = build(:person, roles: ['admin'])
    person.authority.should eq(1)
    person = build(:person, roles: ['owner'])
    person.authority.should eq(2)
    person = build(:person, roles: ['admin', 'owner'])
    person.authority.should eq(3)
    person = build(:person, roles: ['user'])
    person.authority.should eq(4)
    person = build(:person, roles: ['admin', 'user'])
    person.authority.should eq(5)
    person = build(:person, roles: ['owner', 'user'])
    person.authority.should eq(6)
    person = build(:person, roles: ['admin', 'owner', 'user'])
    person.authority.should eq(7)
  end

  it 'gets role names from authority' do
    person = build(:person, authority: 1)
    person.roles.should eq(['admin'])
    person = build(:person, authority: 2)
    person.roles.should eq(['owner'])
    person = build(:person, authority: 3)
    person.roles.should eq(['admin', 'owner'])
    person = build(:person, authority: 4)
    person.roles.should eq(['user'])
    person = build(:person, authority: 5)
    person.roles.should eq(['admin', 'user'])
    person = build(:person, authority: 6)
    person.roles.should eq(['owner', 'user'])
    person = build(:person, authority: 7)
    person.roles.should eq(['admin', 'owner', 'user'])
  end
end
