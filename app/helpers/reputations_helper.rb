module ReputationsHelper
  def vote_path(reputable, vote_type)
    reputable_id = reputable.id
    reputable_type = reputable.class.name
    vote_user_path(reputable_id: reputable_id, reputable_type: reputable_type, vote_type: vote_type)
  end
end
