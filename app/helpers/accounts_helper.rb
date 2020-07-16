# frozen_string_literal: true

module AccountsHelper
  def delete_account_button(account)
    return unless RemoveAccountPolicy.new(account).allowed?

    link_to 'Delete', account_path(account), id: account.id, method: :delete,
    class: 'button button secondary', data: { confirm: 'Are you sure?' }
  end

  def color_status_total_balance(total_balance)
    content_tag(:h3, total_balance, style: "color: #{css_color(total_balance)}", id: 'total-balance')
  end

  private

  def css_color(total_balance)
    total_balance.negative? ? 'red' : 'green'
  end
end
