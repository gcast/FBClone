class Notification < ActiveRecord::Base

	# Rails.application.routes.url_helpers
	# message_path(self.notifiable)

	validates :notifiable_id, :notifiable_type, :user_id, :event_id, presence: true

	belongs_to :notifiable, polymorphic: true

	belongs_to(
		:user, 
		class_name: "User",
		foreign_key: :user_id,
		primary_key: :id
	)

	EVENTS = {
    	1 => "received friend request",
    	2 => "new friend",
    	3 => "commented on post",
    	4 => "commented on photo",
    	5 => "tagged in a post",
    	6 => "posted on your wall"
  }

  def get_url
  	if self.event_id == 1 
  		request = self.notifiable
  		return "users/#{request.requestor.id}"
  	elsif self.event_id == 2
  		friendship = self.notifiable
  		return "users/#{friendship.friend.id}"
  	# elsif self.event_id == 3

  	# elsif self.event_id == 4

  	elsif self.event_id == 5
  		post_tag = self.notifiable
  		return "You were tagged in a post by: #{post_tag.post.author.firstName} #{post_tag.post.author.lastName}"
  		# return #post_url
  	elsif self.event_id == 6
  		post = self.notifiable
  		return "#{post.author.firstName} #{post.author.lastName} posted on your wall."	
  	end
  end

  def get_text
  	if self.event_id == 1 
  		request = self.notifiable
  		return "You received a friend request from #{request.requestor.firstName} #{request.requestor.lastName}"
  	elsif self.event_id == 2
  		friendship = self.notifiable
  		return "You are now friends with #{friendship.friend.firstName} #{friendship.friend.lastName}"
  	# elsif self.event_id == 3

  	# elsif self.event_id == 4

  	elsif self.event_id == 5
  		post_tag = self.notifiable
  		return "You were tagged in a post by: #{post_tag.post.author.firstName} #{post_tag.post.author.lastName}"
  	elsif self.event_id == 6
  		post = self.notifiable
  		return "#{post.author.firstName} #{post.author.lastName} posted on your wall."	
  	end
  end

end
