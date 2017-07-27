require 'capistrano/sync-postgresql/psql_helpers'

include Capistrano::SyncPostgresql::PsqlHelpers

namespace :load do
  task :defaults do
    set :filename, -> { "#{fetch(:pg_database_from)}-#{Time.now.strftime("%Y-%m-%d-%H-%M")}.sql.gz" }
    set :remote_tmp_dir, '/tmp/'
    set :local_tmp_dir, 'tmp/'
    set :local_file, -> { "#{fetch(:local_tmp_dir)}#{fetch(:filename)}" }
    set :remote_file, -> { "#{fetch(:remote_tmp_dir)}#{fetch(:filename)}" }
  end
end

namespace :postgresql do
  desc "Sync remote server to another stage `--to:stage_name`"
  task :sync do
    remote_file = fetch(:remote_file)
    on roles(:db) do
      pg_dump_to remote_file
      download! remote_file, fetch(:local_tmp_dir)
    end
    to = ENV['to']
    if to && to.to_s == 'local'
      puts "Not yet implemented"
    else
      invoke to
      on roles(:sync) do |host|
        upload! fetch(:local_file), remote_file
        within current_path do
          with rails_env: fetch(:rails_env) do
            rake "db:drop db:create"
            pg_restore_from remote_file
          end
        end
      end
    end
  end
end