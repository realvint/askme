class Question < ApplicationRecord
  BODY_MAX_LENGTH = 255

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions

  validates :body, presence: true, length: { maximum: BODY_MAX_LENGTH }
end
