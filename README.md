# Capistrano::SyncPostgreSQL

**Note: this plugin works only with Capistrano 3.** Plase check the capistrano
gem version you're using before installing this gem:
`$ bundle show | grep capistrano`

### About

Capistrano Sync PostgreSQL plugin helps to sync database data from 1 stage to local or another stage.

### Usage

To sync from production to staging database (declared stage is always the from and you need to explicitly declare the destination stage):

1. Add `sync` host role in your staging configuration `config/deploy/staging.rb`:

```
server 'example.com', roles: %w{web app db sync}
```

2. Then:

```
$ cap production postgresql:sync to=staging
```

If you just want to import data locally (NOT YET IMPLEMENTED):

    $ cap production postgresql:sync to=local

Important: this task is dropping and re-creating your destination database, all data previously in dstination database will be lost. Do backup your data as a precaution before syncing them.

Remark: As for setup task, your database user need to be able to have create database permission.

### Contributing and bug reports

Contributions and improvements are very welcome.

If something is not working for you, or you find a bug please report it.

### License

[MIT](LICENSE.md)
