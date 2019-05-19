# Helper Commands


## Debugger
- Insert `binding.pry` in the code

## General commands
- `rake db:migrate` for running migrations
- `rake db:seed` for running the seeding operations
- For generation model level annotations use the following command
```sh
annotate --exclude tests,fixtures,factories,serializers -p bottom -i --show-indexes -k --show-foreign-keys -s --classified-sort
```
- Drop db, create db, migrate db, seed db
```sh
dropdb gringotts_dev && createdb gringotts_dev && rake db:migrate && rake db:seed
```