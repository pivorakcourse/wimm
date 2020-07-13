# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Record do
  context 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:account) }
    it { is_expected.to belong_to(:category) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { expect(:amount).not_to be(0) }
    it { expect(subject).to validate_numericality_of(:amount) }
  end
end
