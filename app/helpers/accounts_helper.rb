# frozen_string_literal: true

module AccountsHelper
  def delete_account_button(account)
    return unless RemoveAccountPolicy.new(account).allowed?

    link_to 'Delete', account_path(account), id: account.id, method: :delete,
    class: 'button button secondary', data: { confirm: 'Are you sure?' }
  end

  def maybe_make_favorite_account_link(_account)
    link_to 'Make it favorite',
            account_favorite_path(@account),
            method: :put,
            class:  'button'
  end

  FAVORITE_TAG = '(Favorite)'

  def maybe_favorite_account_tag(account)
    return unless account.id == current_user.favorite_account_id

    content_tag :span, FAVORITE_TAG
  end

  def color_status_total_balance(total_balance)
    content_tag(:h3, total_balance, style: "color: #{css_color(total_balance)}", id: 'total-balance')
  end

  private

  def css_color(total_balance)
    total_balance.negative? ? 'red' : 'green'
  end
end
