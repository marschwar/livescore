class Team < ActiveRecord::Base
  belongs_to :user

  def abbreviated_name
  	if /(?<team_name>.*)\s(?<suffix>U\d+)\s*$/i =~ name
	    short_name = team_name.split.map { |s| s[0] }.join
	    "#{short_name} #{suffix.upcase}"
	  else
	    name.split.map { |s| s[0] }.join
		end
  end

private
	def age_suffix?
		/.*([Uu]\d+)\s*$/.match name
	end
end
