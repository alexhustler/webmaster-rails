class Webmaster::Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include CreatedAgo

  # attibutes
  field :name
  field :message
  field :subject
  field :reply_to # contacts email or phone
  field :archived, type: Boolean, default: false

  # validations
  validates_presence_of :message, :reply_to

  # scopes
  default_scope    -> { desc(:created_at) }
  scope :inbox,    -> { where(archived: false ) }
  scope :archived, -> { where(archived: true ) }

  # helpers
  def chr_name_or_reply_to
    (self.name.nil? or self.name.empty?) ? self.reply_to : self.name
  end
end