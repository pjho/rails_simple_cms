class Post < ActiveRecord::Base
  custom_slugs_with(:slug)

  before_save :parameterize_slug
  
  validates :title, presence: true
  validates :content, presence: true
  validates :slug, uniqueness: true 
    # format: { with: /\A^[A-z\-\s]+\z/, message: "only allows letters and hyphen (-)" }

  private

  # This could be shared between Pages & Posts
  def parameterize_slug
    self.slug = self.title if self.slug.empty?
    self.slug = self.slug.downcase.parameterize
  end

end
