class User < ActiveRecord::Base

  include HasImage

  alias_attribute :name, :common_name

  scope :is_like, -> (name) { where("upper(common_name) like ?", "%#{name.upcase}%")}
end
