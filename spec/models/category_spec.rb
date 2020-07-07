# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category do
  context 'relations' do
    it { is_expected.to belong_to(:user) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
  end
end
