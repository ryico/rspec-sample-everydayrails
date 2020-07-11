class Note < ApplicationRecord
  belongs_to :project
  belongs_to :user
  scope :search, ->(term) {
    where("LOWER(message) LIKE ?", "%#{term.downcase}%")
  }
end
