module ModelHelpers
  ##
  # Create followship of given user to odd index of a list of created topics
  #
  # * *Param*    :
  #   - +user_id+::   the user id of user  to peform the follow
  # * *Returns* :
  #   - array of the odd id topic which is followed by the user
  ##
  def create_followship(user_id)
    followed_topics = FactoryGirl.create_list(:topic,20).
                                  reject{|t| t.id % 2 == 0}
    followed_topics.each do |t|
      FactoryGirl.create(:followship, user_id: user_id, topic_id: t.id)
    end
    followed_topics 
  end

  ##
  # Create favoring of given user_id and some generated posts
  #
  # * *Param*    :
  #   - +user_id+::   the user id of user  to peform the follow
  # * *Returns* :
  #   - array of the odd post which is favored by the user
  ##
  def create_favoring(user_id) 
    # create 20 post of topic1, favor odd id post
    posts = FactoryGirl.create_list(:post,20, user_id: user_id)
    #favoring odd index post
    favor_posts = posts.reject{|p| p.id % 2 ==0}
    favor_posts.each do |p|
      FactoryGirl.create(:favor, user_id: user_id, post_id: p.id)
    end
    favor_posts
  end

end
