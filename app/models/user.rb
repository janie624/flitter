class User < ActiveRecord::Base
	include Gravtastic
  gravtastic :size => 50
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :user_name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  validates_format_of :user_name, :with => /^[-\w\_@]+$/i, :allow_blank => true, :message => "should be a valid user name."
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}+$/i
  validates_exclusion_of :user_name, :in => %w(admin superuser, following), :message => " is not a valid user name."


  has_many :flits, :dependent => :destroy
	has_many :friendships
	has_many :friends, :through => :friendships
	
	def add_friend(friend)
	  friendship = friendships.build(:friend_id => friend.id)
	  if !friendship.save
	    logger.debug "User '#{friend.email}' already exists in the user's friendship list."
	  end
	end

	def remove_friend(friend)
	  friendship = self.friendships.where(:friend_id => friend.id).first
	  if friendship
	    friendship.destroy
	  end
	end

	def friends_of
		Friendship.where("friend_id = ?", self.id).map{ |f| f.user}
	end

	def is_friend?(friend)
		return self.friends.include? friend
	end

	def all_flits
		Flit.where('user_id in (?)', friends.map(&:id).push(self.id)).order("created_at desc")
	end

	def self.find_by_search_query(q)
		User.where("user_name LIKE ? OR email LIKE ?", "%#{q}%", "%#{q}%")
	end
end
