class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthabl
  has_one:azufang
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
