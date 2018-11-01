class Ad < ActiveRecord::Base
  # Callbacks
  before_save :md_to_html

  # Associations
  belongs_to :category, counter_cache: true
  belongs_to :member

  # Validates
  validates :title, :category, :picture, :description_md, :description_short, :finish_date, presence: true
  validates :price, numericality: { greater_than: 0 }


  # Scopes
  scope :descending_order, ->(quantity = 10, page=1) { limit(quantity).order(created_at: :desc).page(page).per(6) }
  scope :to_the, ->(member) { where(member: member) }
  scope :by_category, ->(id) { where(category: id) }
  scope :search, ->(q, page=1) { where("lower(title) LIKE ?", "%#{q.downcase}%").page(page).per(6) }

  # gem money-rails
  monetize :price_cents

  # paperclip
  has_attached_file :picture, styles: { large: "800x300#", medium: "320x150#", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  private

  def md_to_html
    options = {
        filter_html: true,
        link_attributes: {
          rel: "nofollow",
          target: "_blank"
        }
    }

    extensions = {
      space_after_headers: true,
      autolink: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    self.description = markdown.render(self.description_md)

  end
end
