class Tag < ActiveRecord::Base

has_many :taggings
has_many :posts, through: :taggings

validates :name, presence: true
validates :color, format: { with: /\A#[A-F0-9]{6}+\z/,
    message: "Color must be in the format #ABC123" }

end
