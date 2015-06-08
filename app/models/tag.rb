class Tag < ActiveRecord::Base
# after_save { Tag::generateTagCss }
before_validation :upcase_color

has_many :taggings, dependent: :destroy
has_many :posts, through: :taggings

validates :name, presence: true
validates :color, format: { with: /\A#[A-F0-9]{6}+\z/,
    message: "Color must be in the format #ABC123" }

private
  def self.generateTagCss
    TagCssGenerator.generate
  end


  def upcase_color
    self.color = self.color.upcase
  end

end
