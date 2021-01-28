class User < ActiveRecord::Base
    has_secure_password
    has_many :locations, :dependent => :delete_all
    validates :username, presence: true
end