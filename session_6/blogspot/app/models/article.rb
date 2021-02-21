class Article < ApplicationRecord
  validates :title, presence: true, length: {maximum: 255}
  validates :content, presence: true

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_one_attached :cover_photo

  scope :with_title, ->(query) {
    return nil if query.blank?

    query.downcase!

    where("LOWER(title) LIKE ?", "%#{query}%")
  }

  paginates_per 8

  def paragraphs
    content.split("\r\n").select(&:present?)
  end
end
