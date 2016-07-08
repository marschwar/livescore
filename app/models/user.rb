require 'carrierwave/orm/activerecord'

class User < ActiveRecord::Base

  mount_uploader :avatar, AvatarUploader

  # TODO remove in the future
  include HasImage

  alias_attribute :name, :common_name
  alias_attribute :uploader, :avatar

  scope :is_like, -> (name) { where("upper(common_name) like ?", "%#{name.upcase}%")}
  scope :active, -> { where(active: true) }

end
