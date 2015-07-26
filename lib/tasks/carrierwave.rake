
namespace :carrierwave do

  task :prepare => :environment do
    require 'carrierwave'
  end

  desc 'Migrate Team Logos from database storage to carrierwave'
  task :migrate_logos, [:base_url] => :prepare do |task, args|
    p args
    if args.base_url
      base_url = args.base_url
      Team.where('encoded_image is not null').each do |team|
        logo_url = base_url + "/teams/#{team.id}.#{team.image_type}"
        Rails.logger.info "Setting team logo for #{team.name} to #{logo_url}"
        team.remote_logo_url = logo_url
        team.save!
      end
    else
      Rails.logger.fatal "base_url missing in arguments"
    end
  end
end
