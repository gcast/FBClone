class User < ActiveRecord::Base

	include PgSearch
	multisearchable :against => [:first_name, :last_name, :user_albums]

	before_validation :ensure_session_token!

	validates :first_name, :last_name, :email, :password_digest, :birthDate, :session_token, presence: true
	validates :email, uniqueness: true
	validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
	validates :password, :length => { minimum: 6, allow_nil: true }

	after_commit :create_default_albums!, :on => [:create]

	has_many(
		:message_threads_as_one, 
		class_name: "MessageThread",
		foreign_key: :user_one,
		primary_key: :id
	)

	has_many(
		:message_threads_as_two,
		class_name: "MessageThread",
		foreign_key: :user_two,
		primary_key: :id
	)

	has_many(
		:sent_messages,
		class_name: "Message",
		foreign_key: :sender_id,
		primary_key: :id
	)

	has_many(
		:recieved_messages,
		class_name: "Message",
		foreign_key: :recipient_id,
		primary_key: :id
	)

	has_many(
		:liked_items, 
		class_name: "Like",
		foreign_key: :liker_id, 
		primary_key: :id
	)

	has_many(
		:belongs_to_group,
		class_name: "FriendGroupJoin",
		foreign_key: :friend_id,
		primary_key: :id
	)

	has_many(
		:created_groups,
		class_name: "FriendGroup",
		foreign_key: :owner_id,
		primary_key: :id
	)

	has_many(
		:notifications,
		class_name: "Notification",
		foreign_key: :user_id,
		primary_key: :id
	)

	has_many(
		:sent_requests, 
		class_name: "FriendRequest",
		foreign_key: :requestor_id, 
		primary_key: :id
	)

	has_many(
		:received_requests, 
		class_name: "FriendRequest",
		foreign_key: :requestee_id, 
		primary_key: :id
	)

	has_many(
		:owned_friendships, 
		class_name: "Friendship",
		foreign_key: :user_id,
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

	has_many(
		:albums, 
		class_name: "Album",
		foreign_key: :owner_id,
		primary_key: :id
	)

	has_many :friends, through: :owned_friendships, source: :friend
	has_many :photos, through: :albums, source: :photos
	has_many :group_memberships, through: :belongs_to_group, source: :friend_group
	has_many :received_shares, through: :group_memberships, source: :shares

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

	def turn_off_session_active!
		self.session_active = false
		self.save!
	end

	def turn_on_session_active!
		self.session_active = true 
		self.save!
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

	def online_friends
		self.friends.where("session_active = true")
	end

	def friendship(user)
		self.friends.where("friend_id = ?", user.id).first #Use try?
	end

	def can_request_friendship?(user)
		!friends_with?(user) && 
		!sent_request_to?(user) && 
		!received_request_from?(user)
	end

	def has_friends?
		self.friends.length > 0
	end

	def friends_with?(user)
		has_friends? &&
		!self.friends.where("friend_id = ?", user.id).empty?
	end

	def get_friendship(user)
		self.owned_friendships.where("friend_id = ?", user.id).first
	end

	def has_sent_requests?
		!self.sent_requests.empty?
	end

	def sent_request_to?(user)
		self.has_sent_requests? &&
		!self.sent_requests.where("requestee_id = ?", user.id).empty?
	end

	def has_received_requests?
		!self.received_requests.empty?
	end

	def received_request_from?(user)
		self.has_received_requests? && 
		!self.received_requests.where("requestor_id = ?", user.id).empty?
	end

	def full_name
		"#{self.first_name} #{self.last_name}"
	end

	def get_profile_photos
		@profile_photos ||= self.albums.where("name = 'Profile Photos'").first.photos
	end

	def get_cover_photos
		@cover_photos ||= self.albums.where("name = 'Cover Photos'").first.photos
	end

	#FOR PG MULTISEARCH TO PREVENT N+1 QUERIES (Does it work?)
	def user_albums 
		self.albums
	end

	#CHANGE OTHER PLACES WHERE YOU GET PROFILE PHOTOS & CHECK IF EMPTY. ALL LOGIC DONE HERE
	def profile_photo_url
		profile_photos = get_profile_photos
		profile_photo_url = profile_photos.empty? ? Photo.default_photo_url : profile_photos.first.file.url(:thumb)
		profile_photo_url
	end

	# def belongs_to_groups?(groups)
	# 	!self.belongs_to_group.where("group_id = ?", group.id).empty?
	# end

	private
	def ensure_session_token!
		self.session_token ||= SecureRandom.urlsafe_base64(16)
	end

	def create_default_albums! 
		self.albums.create([{name: "Profile Photos"}, {name: "Cover Photos"}])
	end

end
