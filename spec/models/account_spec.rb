# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:balance) }
    it { should validate_numericality_of(:balance) }
  end

  context 'relations' do
    it { should belong_to(:user) }
  end
end
