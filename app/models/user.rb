class User < ActiveRecord::Base

  include HasImage

  scope :is_like, -> (name) { where("upper(common_name) like ?", "%#{name.upcase}%")}
end
