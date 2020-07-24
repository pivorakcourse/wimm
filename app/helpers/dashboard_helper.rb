# frozen_string_literal: true

module DashboardHelper
  ACTIVE = 'active'

  def tab_active?(id)
    return ACTIVE if tab == id || (tab.nil? && id == 'withdraw')
  end

  def tab_pane_active?(id)
    return '' unless request.url.include?(id)

    ACTIVE
  end

  def tab_nil?(id)
    if tab.nil?
      ACTIVE
    else
      tab_pane_active?(id)
    end
  end

  private

  def tab
    @tab ||= params[:tab]
  end
end
