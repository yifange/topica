Topica
======
* `ngapp`: AngularJS app, the frontend assets.  
Use `grunt server` to start the frontend server.
Use `grunt clean --force` and `grunt build` to copy the frontend code to the Rails app folder.

* `topica`: Rails app, the backend code, most of the meaningful work for iteration2 are in here.  
Use `rails server` to start the api server.  
Most of the class method we designed, like CRUDs, are implemented by Rails automagically because of ActiveRecords.  
E.g. we defined in the [User model](https://pl.cs.jhu.edu:8000/oose-13-group-12/project/blob/master/topica/app/models/user.rb) that a user should _has many_ _feeds_ by saying `has_many :feeds`, then we get an instance method `User#feeds` to get all the feeds that associated with this user instance.

