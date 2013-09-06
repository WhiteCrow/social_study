module ReputationsHelper
  ['vote', 'study', 'grade'].each do |repute|
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

  #def vote_path(reputable, vote_type)
  #  reputable_id = reputable.id
  #  reputable_type = reputable.class.name
  #  vote_user_path(reputable_id: reputable_id, reputable_type: reputable_type, vote_type: vote_type)
  #end

  #def study_path(reputable, study_type)
  #  reputable_id = reputable.id
  #  reputable_type = reputable.class.name
  #  study_user_path(reputable_id: reputable_id, reputable_type: reputable_type, study_type: study_type)
  #end

  #def grade_path(reputable, grade_type)
  #  reputable_id = reputable.id
  #  reputable_type = reputable.class.name
  #  grade_user_path(reputable_id: reputable_id, reputable_type: reputable_type, grade_type: grade_type)
  #end
end
