# frozen_string_literal: true

module DestroyAccountHelper
  def delete_account_button(account)
    return unless RemoveAccountPolicy.new(account).allowed?

    link_to 'Delete', account_path(account), id: account.id, method: :delete,
    class: 'button button secondary', data: { confirm: 'Are you sure?' }
  end
end
