module KnowledgesHelper
  def knowledge_tab
    case params[:tab]
    when nil
      render 'tab_reviews'
    when 'notes'
      render 'tab_notes'
    end
  end
end
