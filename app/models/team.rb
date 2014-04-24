class Team < ActiveRecord::Base
  belongs_to :user

  def abbreviated_name
    name.split.map { |s| s[0] }.join
  end
end
