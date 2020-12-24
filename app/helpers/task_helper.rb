module TaskHelper
  def add_hidden_class(path)
    'hidden' if current_page?(path)
  end
end