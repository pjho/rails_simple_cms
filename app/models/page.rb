class Page < ActiveRecord::Base
  custom_slugs_with(:slug)

  validates :title, presence: true
  validates :content, presence: true
  validates :slug, uniqueness: true

end
