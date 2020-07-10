module DestroyAccountHelper
  def delete_account_button(account)
    if RemoveAccountPolicy.new(account).allowed?
      link_to "Delete", account_path(account), action: "destroy",
      id: account.id, method: :delete, class: 'button button secondary', data: { confirm: 'Are you sure?'}
    end
  end
end
