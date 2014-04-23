class User < ActiveRecord::Base

	validates :firstName, :lastName, :email, :password_digest, :birthDate, :session_token, presence: true
	validates :email, uniqueness: true
	validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
	validates :password, :length => { minimum: 6, allow_nil: true }
	before_validation :ensure_session_token!

	has_many(
		:friendRequestAsRequestor, #change to snake case
		class_name: "FriendRequest",
		foreign_key: :requestorID, 
		primary_key: :id
	)

	has_many(
		:friendRequestAsRequestee, #change to snake case
		class_name: "FriendRequest",
		foreign_key: :requesteeID, 
		primary_key: :id
	)

	has_many(
		:owned_friendships, 
		class_name: "Friendship",
		foreign_key: :userID,
		primary_key: :id
	)

	has_many(
		:authored_posts,
		class_name: "Post",
		foreign_key: :author_id,
		primary_key: :id
	)

	has_many(
		:received_posts,
		class_name: "Post",
		foreign_key: :recipient_id,
		primary_key: :id
	)

	has_many(
		:taggings, 
		class_name: "PostTag",
		foreign_key: :tagged_user_id,
		primary_key: :id
	)

	has_many(
		:authored_comments, 
		class_name: "Comment",
		foreign_key: :author_id,
		primary_key: :id
	)

	has_many :friends, through: :owned_friendships, source: :friend

	attr_reader :password

	def self.find_by_credentials(email, password)
		@user = User.find_by_email(email)
		return nil if @user.nil?
		@user.is_password?(password) ? @user : nil
	end

	def reset_session_token!
		self.session_token = SecureRandom.urlsafe_base64(16)
		self.save!
		self.session_token
	end

	def is_password?(unencrypted_password)
		BCrypt::Password.new(self.password_digest).is_password?(unencrypted_password)
	end

	def password=(unencrypted_password)
		if unencrypted_password.present?
			@password = unencrypted_password
			self.password_digest = BCrypt::Password.create(unencrypted_password)
		end
	end

	def can_request_friendship?(user)
		!request_exists?(user) && !already_friends?(user)
	end

	def request_exists?(user)
		if (self.friendRequestAsRequestor.where("requesteeID = ?", user.id).empty? &&
			self.friendRequestAsRequestee.where("requestorID = ?", user.id).empty?)
			return false
		else
			return true
		end
	end

	def already_friends?(user)
		self.friends.where("friendID = ?", user.id).length != 0
	end

	private
	def ensure_session_token!
		self.session_token ||= SecureRandom.urlsafe_base64(16)
	end

end
