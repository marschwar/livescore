desc "This task removes notes for old games from the database"
task :cleanup_notes => :environment do
  puts "Removing old notes..."
  Note.joins(:game).where("games.game_day < ?", 6.months.ago).delete_all
  puts "done."
end
