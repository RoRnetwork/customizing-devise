class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable, :lockable, :timeoutable 
  validates :first_name,:last_name,:avatar,presence: true
   mount_uploader :avatar, AvatarUploader
end
