class Status < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

  validates :creator, presence: true
  validates :body, presence: true, length: {minimum: 8}

  after_save :extract_mentions

  def extract_mentions
    if  self.body =~ /@(\w*)/
      user = User.find_by username: $1
      if user
        Mention.create(user_id: user.id, status_id: self.id)
      end
    end
  end
end
