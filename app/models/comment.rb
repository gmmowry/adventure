class Comment <ActiveRecord::Base

  belongs_to :commenter, class_name: "User"
  belongs_to :post
  has_many :replies
  has_many :votes, :as => :votable

  scope :most_popular, -> { joins(:votes).group("comments.id").order("votes.count DESC, created_at desc") }


  def total_votes
    self.votes.where(vote:true).count - self.votes.where(vote:false).count
  end

end





