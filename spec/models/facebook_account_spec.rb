require 'spec_helper'

describe FacebookAccount do
  it{ should validate_presence_of :identifier }
  it{ should validate_uniqueness_of :identifier }

  it { should belong_to :user }
end
