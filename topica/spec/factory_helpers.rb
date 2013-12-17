module FactoryHelpers
  ##
  # Create a list of topics. Each user create a given number of topics.
  #
  # * *Param*   :
  #   - +user_id+:  the user id of user to create topics
  #   - +num+:      the number of topic each user create 
  # * *Returns* :
  #   - array of the topics created
  ##
  def create_topics(user_ids, num)
    r = []
    user_ids.each do |u_id|
      (1...num).each do
        r << FactoryGirl.create(:topic, user_id: u_id)
      end
    end
    r
  end

  ##
  # Create a list of posts. Each user create a given number of posts,
  # the topic of each post is choose randomly
  #
  # * *Param*   :
  #   - +user_id+:  the user id of user to create posts
  #   - +topics+:   the topics to choose from
  #   - +num+:      the number of post each user create
  # * *Returns* :
  #   - array of the topics created
  ##
  def create_posts(user_ids, topics, num)
    r = []
    user_ids.each do |u_id|
      (1..num).each do
        r << FactoryGirl.create(:post, 
                                user_id: u_id)
      end
    end
    r
  end
  
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


  def init_integration_test 
    users = FactoryGirl.create_list(:user, 5)
    user_ids = users.map{|u| u.id}
    topics = create_topics(user_ids, 2) #each user creates 2 topic
    posts = create_posts(user_ids, topics, 3)  #each user create 3 post
    true
  end
end
