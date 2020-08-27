#Our only model is User 
#This validates some of the attributes of our user so no one can login without inputting their name, email and password. 

class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password
end