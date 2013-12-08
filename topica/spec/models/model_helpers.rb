module ModelHelpers
  ##
  # Create followship of given user to odd index of given topic_ids
  #
  # * *Param*    :
  #   - +topic_ids+:: a array of topic ids 
  #   - +user_id+::   the user id of user  to peform the follow
  # * *Returns* :
  #   - array of the odd topic id which is followed by the user
  ##
  def create_followship_odd_idx_topic(topic_ids, user_id)
    odd_topic_ids = topic_ids.reject{|i| i % 2 == 0}
    odd_topic_ids.each do |t_id|
      FactoryGirl.create(:followship, user_id: user_id, topic_id: t_id)
    end
    odd_topic_ids
  end
end
