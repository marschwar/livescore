class Game < ActiveRecord::Base
  PERIODS = %w(unstarted quarter_1 quarter_2 half quarter_3 quarter_4 final)
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'

  scope :relevant, -> { where("game_day > '#{6.days.ago}'") }

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

private

  def total(type)
    (1..4).inject(0) do |sum, quarter|
      sum + score(type, quarter)
    end
  end

  def score(type, quarter)
    raise unless (1..4).include? quarter
    self.send("#{type}_quarter_#{quarter}")
  end
end
