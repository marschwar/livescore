class Game < ApplicationRecord

  PERIODS = %w(unstarted quarter_1 quarter_2 half quarter_3 quarter_4 final)

  belongs_to :user
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  has_many :supporters
  has_many :notes
  has_many :comments

  validates :home_team, :away_team, presence: true

  scope :relevant, -> { where("game_day > '#{6.days.ago}' and game_day < '#{6.days.from_now}'") }
  scope :with_team, -> (team) { where("home_team_id = ? or away_team_id = ?", team, team) }

  def supported_by(user)
    Supporter.exists? user_id: user, game_id: self
  end

  def title
    "#{home_team.name} vs. #{away_team.name}"
  end

  def total_home
    total :home
  end

  def total_away
    total :away
  end

  def home_score(quarter)
    score :home, quarter
  end

  def away_score(quarter)
    score :away, quarter
  end

  def started?
    not unstarted?
  end

  def unstarted?
    period.to_sym == :unstarted
  end

  def playing?
    period.to_s.start_with? 'quarter'
  end

  def final?
    period.to_sym == :final
  end

  def total(type)
    (1..4).inject(0) do |sum, quarter|
      sum + score(type, quarter)
    end
  end

  def score(type, quarter)
    raise unless (1..4).include? quarter
    self.send("#{type}_quarter_#{quarter}")
  end

  def possession?(type)
    playing? && possession.try(:to_sym) == type.to_sym
  end

  # adds the amount of points to the home or away team in the current period if playing
  def add(team, points)
    raise 'not playing' unless playing?
    raise unless %w(home away).include? team
    current_points = send "#{team}_#{period}"
    send("#{team}_#{period}=", current_points + points.to_i)
  end
end
