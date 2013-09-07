module ReputationsHelper
  ['vote', 'study', 'grade', 'collect'].each do |repute|
    define_method "#{repute}_path" do |reputable, repute_type|
      reputable_id = reputable.id
      reputable_type = reputable.class.name
      # example: 
      # vote_user_path(reputable_id: reputable_id, reputable_type: reputable_type, vote_type: repute_type)
      self.send "#{repute}_user_path", {
        reputable_id: reputable_id,
        reputable_type: reputable_type,
        :"#{repute}_type" => repute_type
      }
    end
  end

  def repute_icon(type)
    if Reputation::StudyTypes.include? type
      content_tag :span, class: 'alert alert-success' do
        type
      end

    elsif Reputation::GradeTypes.include? type
      icons = type.to_i.times.map do
        "<span class='hard-graded-type icon-star'></span>&nbsp;"
      end.join
      raw icons

    elsif Reputation::CollectTypes.include? type
      content_tag :span, class: 'alert' do
        content_tag :span do
          '已收藏'
        end
      end
    end
  end

  def collect_link(reputable)
    link_to collect_path(reputable, 'collect'), method: :post, remote: true,
                                          class: "alert collect-link" do
      span = content_tag :span do
        @collect_state.present? ? '已收藏' : '收藏'
      end
      div = content_tag :div, '', class: 'icon-bookmark'
      span.concat(raw '&nbsp;').concat(div)
    end
  end
end
