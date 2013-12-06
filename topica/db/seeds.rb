# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
User.create(username: "Yifan", name: "Yifan Ge", email: "yifan.ge101@gmail.com",
            password: "123", password_confirmation: "123")
User.create(username: "Fenghuan", name: "Fenghuan Lu",email: "fenghuan@gmail.com",
            password: "123", password_confirmation: "123")
User.create(username: "Paul", name:"Paul Wilkening", email: "paul@gmail.com",
            password: "123", password_confirmation: "123")
User.create(username: "Jiaqi", name:"Jiaqi Gao", email: "jiaqi@gmail.com",
            password: "123", password_confirmation: "123")
User.create(username: "Xiang", name:"Xiang xiang", email: "xiang@gmail.com",
            password: "123", password_confirmation: "123")
User.create(username: "Dongye", name:"Dongye Shen", email: "dongye@gmail.com",
            password: "123", password_confirmation: "123")

Feed.delete_all
Feed.create(user_id: 1, name: "Music")
Feed.create(user_id: 1, name: "Programming")
Feed.create(user_id: 1, name: "Reading")
Feed.create(user_id: 2, name: "Music")
Feed.create(user_id: 2, name: "Programming")
Feed.create(user_id: 3, name: "Programming")
Feed.create(user_id: 4, name: "Programming")
Feed.create(user_id: 5, name: "Programming")
Feed.create(user_id: 6, name: "Programming")

# feed_id deleted
Topic.delete_all
Topic.create(user_id: 1, name: "c++", topic_type: 1) # 1 to be public
Topic.create(user_id: 1, name: "python", topic_type: 1)
Topic.create(user_id: 2, name: "java", topic_type: 1)
Topic.create(user_id: 2, name: "c++", topic_type: 1)
Topic.create(user_id: 3, name: "country", topic_type: 1)

# feed_id added
Followship.delete_all
Followship.create(user_id: 1, topic_id: 3, feed_id: 2)
Followship.create(user_id: 1, topic_id: 4, feed_id: 2)
Followship.create(user_id: 1, topic_id: 5, feed_id: 1)

# user_id, topic_id deleted
Post.delete_all
Post.create(title: "c++ string", content: "It's not convenient to convert a single character to a string.")
Post.create(title: "cmake", content: "CMake is a great tool.")
Post.create(title: "JVM", content: "JVM provides portability.")

Favor.delete_all
Favor.create(user_id: 1, post_id: 3)
Favor.create(user_id: 2, post_id: 1)
Favor.create(user_id: 2, post_id: 2)

Comment.delete_all
Comment.create(post_id: 1, user_id: 3, content: "Agree.")
Comment.create(post_id: 1, user_id: 4, content: "same.")
Comment.create(post_id: 2, user_id: 5, content: "Really?")

Category.delete_all
Category.create(post_id: 1, topic_id: 1)
Category.create(post_id: 1, topic_id: 2)
Category.create(post_id: 2, topic_id: 1)
Category.create(post_id: 3, topic_id: 3)
