class Notification < ActiveRecord::Base

  include Rails.application.routes.url_helpers

  EVENTS = {
      1 => "received friend request",
      2 => "new friendship",
      3 => "commented on your post",
      4 => "tagged you in a post",
      5 => "posted on your wall"
  }

	validates :notifiable, :user, :event_id, presence: true
  validates :event_id, inclusion: { in: EVENTS.keys }
  validates :is_read?, inclusion: { in: [true, false] }

	belongs_to :notifiable, polymorphic: true

	belongs_to(
		:user, 
		class_name: "User",
		foreign_key: :user_id,
		primary_key: :id,
    # counter_cache: true #READ UP WHAT THIS DOES AGAIN
	)

  scope :read, -> { where(is_read?: true) }
  scope :unread, -> { where(is_read?: false) }
  

  def get_url
    element = self.notifiable

  	if self.event_id == 1 
  		return wall_user_url(element.requestor_id)
  	elsif self.event_id == 2
  		return wall_user_url(element.friend)
    elsif self.event_id == 3
      return wall_user_url(element.commentable.recipient_id)
    elsif self.event_id == 4
      return wall_user_url(element.post.recipient_id)
    elsif self.event_id == 5
      return wall_user_url(element.recipient_id)
    end

  end

  def get_text
    element = self.notifiable

  	if self.event_id == 1 
  		return "You received a friend request from #{element.requestor.full_name}. Visit their profile."
  	elsif self.event_id == 2
  		return "You are now friends with #{element.friend.full_name}. Vist their profile."
  	elsif self.event_id == 3
      return "#{element.author.full_name} commented your post. Visit their wall."
  	elsif self.event_id == 4
  		return "You were tagged in a post by: #{element.post.author.full_name}. Visit their wall."
  	elsif self.event_id == 5
  		return "#{element.author.full_name} posted on your wall. Visit their wall."	
  	end
  end

  #Add production enviroment
  def default_url_options
    options = {}
    options[:host] = "localhost:3000"
    options
  end

end
