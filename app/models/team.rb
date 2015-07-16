class Team < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user

  friendly_id :name, use: :slugged

  scope :is_like, -> (name) { where("upper(name) like ?", "%#{name.mb_chars.upcase}%")}

  validates :name, presence: true, length: { minimum: 5 }

  def abbreviated_name
  	if /(?<team_name>.*)\s(?<suffix>U\d+)\s*$/i =~ name
	    short_name = team_name.split.map { |s| s[0] }.join
	    "#{short_name} #{suffix.upcase}"
	  else
	    name.split.map { |s| s[0] }.join
		end
  end

  def image_type
    if /^data:image\/(?<suffix>\S+);/ =~ encoded_image
      suffix
    end
  end

  def image_mime_type
    if /^data:(?<mime>image\/\S+);/ =~ encoded_image
      mime
    end
  end

  def raw_image_data
    if encoded_image.present?
      if /base64,(?<raw>.*)/ =~ encoded_image.gsub("\n", '')
        Base64.strict_decode64 raw
      end
    end
  end

private
	def age_suffix?
		/.*([Uu]\d+)\s*$/.match name
	end

end
