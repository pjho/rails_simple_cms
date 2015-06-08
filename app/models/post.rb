class Post < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  custom_slugs_with(:slug)

  before_save :parameterize_slug

  validates :title, presence: true
  validates :content, presence: true
  validates :slug, uniqueness: true 
    # format: { with: /\A^[A-z\-\s]+\z/, message: "only allows letters and hyphen (-)" }

  # setter for all tags
  def add_tags=(names)
    self.tags << names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create! do |tag|
          tag.color = Tag.random_color
        end
    end
  end

  def add_tags
    # nothing
  end

  def self.tagged_with(id)
    Tag.find_by_id!(id).posts
  end

  private

  # This could be shared between Pages & Posts
  def parameterize_slug
    self.slug = self.title if self.slug.empty?
    self.slug = self.slug.downcase.parameterize
  end

end
