class Question < ApplicationRecord
  BODY_MAX_LENGTH = 255

  belongs_to :user

  validates :body, presence: true, length: { maximum: BODY_MAX_LENGTH }
end
