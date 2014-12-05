require 'rails_helper'

describe Code do

  it 'has a valid factory' do
    code = build(:code)
    expect(code).to be_valid
  end

  it 'is invalid without a code' do
    code = build(:code, code: nil)
    expect(code).to_not be_valid
  end

  it 'is invalid without a description' do
    code = build(:code, description: nil)
    expect(code).to_not be_valid
  end

end
