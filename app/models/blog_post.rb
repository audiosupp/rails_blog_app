class BlogPost < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  scope :draft, lambda { where(published_at: nil) }
  scope :published, lambda { where("published_at <= ?", Time.current) }
  scope :scheduled, lambda { where("published_at > ?", Time.current) }
end
