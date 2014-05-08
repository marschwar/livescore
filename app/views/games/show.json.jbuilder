json.home_team @game.home_team.name
json.away_team @game.away_team.name
json.user @game.user.try(:common_name)
json.(@game, :location, :game_day, :game_time)
json.possession @game.possession if @game.playing?
json.period t("activerecord.values.game.period.#{@game.period}")
json.final @game.final?
json.started @game.started?
json.updated_at do |updated_at|
  updated_at.time @game.updated_at
  updated_at.words distance_of_time_in_words_to_now @game.updated_at, include_seconds: true
end
json.score do |json|
  json.home do |home|
    home.total @game.total :home
    home.periods [@game.home_quarter_1, @game.home_quarter_2, @game.home_quarter_3, @game.home_quarter_4]
  end
  json.away do |away|
    away.total @game.total :away
    away.periods [@game.away_quarter_1, @game.away_quarter_2, @game.away_quarter_3, @game.away_quarter_4]
  end
end

json.notes @notes do |note|
  json.created_at localize note.created_at
  json.text note.text
end