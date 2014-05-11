class User < ActiveRecord::Base

  scope :is_like, -> (name) { where("upper(common_name) like ?", "%#{name.upcase}%")}
end
