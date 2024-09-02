# add that line to create new commit to test with branches and squashing
class BlogPost < ApplicationRecord
  has_rich_text :content
  has_one_attached :cover_image

  validates :title, presence: true
  validates :content, presence: true

  scope :sorted, -> { order(arel_table[:published_at].desc.nulls_first).order(updated_at: :desc) }
  scope :draft, lambda { where(published_at: nil) }
  scope :published, lambda { where("published_at <= ?", Time.current) }
  scope :scheduled, lambda { where("published_at > ?", Time.current) }

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at >= Time.current
  end
end
