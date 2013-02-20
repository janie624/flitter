class Flit < ActiveRecord::Base
  attr_accessible :message, :user_id
  belongs_to :user

  validates_presence_of :user_id

  scope :last_message
end
