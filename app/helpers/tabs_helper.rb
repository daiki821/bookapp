module TabsHelper
  def add_tab_active_id(path)
    'active-tab' if current_page?(path)
  end
end
