# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account::Create do
  let(:current_user) { User.create(email: 'test@test.com', password: 'password') }
  let(:valid_params) { { name: 'NewAccount' } }
  let(:invalid_params) { { name: '' } }
  let(:created_account) { Account.last }

  it 'successfully create account' do
    expect do
      described_class.call(valid_params, current_user)
    end.to change { Account.count }.from(0).to(1)
    expect(created_account.name).to eq valid_params[:name]
  end

  it 'failure with errors' do
    expect do
      described_class.call(invalid_params, current_user)
    end.not_to change { Account.count }

    expect(created_account).to eq nil
  end
end
