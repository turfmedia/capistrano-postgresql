module Capistrano
  module SyncPostgresql
    module PsqlHelpers

      def pg_restore_from(archive)
        conf = get_database_conf
        execute "gunzip -c #{archive} | PGPASSWORD=#{conf['password']} psql -h #{conf['host']} -d #{conf['database']} -U #{conf['username']}"
      end

      def pg_dump_to(file)
        conf = get_database_conf
        execute "PGPASSWORD='#{conf['password']}'' pg_dump -O -h #{conf['host']} -U #{conf['username']} #{conf['database']} | gzip > #{file}"
      end

      private

      def get_database_conf
        local_db_yml = "tmp/database-#{fetch(:stage)}.yml"
        download! shared_path.join('config/database.yml'), local_db_yml
        YAML::load_file(local_db_yml)[fetch(:rails_env).to_s]
      end

    end
  end
end

