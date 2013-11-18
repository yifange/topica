# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
User.create(username: "Yifan", name: "Yifan Ge", email: "yifan@gmail.com",
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

# Topic.delete_all
# Topic.create(user_id: 1, feed_id: 1, )
# Category
# Comment
# Favor
# Followship
# Post
