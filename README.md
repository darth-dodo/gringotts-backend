# gringotts-backend

## Local instructions
- Clone the repo
- Use RVM to install and set ruby to version 2.6.0
- Run `bundle install`
- Install Postgres
- Create development postgres db using the command `createdb gringotts_dev` as mentioned in the `database.yml`
- Run `rake db:migrate` to create all the database objects in your local db
- Run `rake db:seed` to create the first user with the credential
    - Username: admin@gringotts.com
    - Password: `get_rich_or_die_codin`
- Run the local server using the command `rails s`
- Hop on to the site and go to `<your-localhost-with-port>/admin`
- Use the above creds to log into the admin panel

## Heroku
- The dev app is hosted at [gringotts-backend.herokuapp.com](https://gringotts-backend.herokuapp.com)


## ToDo
- [ ] Specs setup
- [ ] Swagger
- [ ] Async using 
- [ ] Heroku add ons
    - [ ] Database backup
    - [ ] Scheduler
    - [ ] Airbrake
- [ ] YAML based config
- [ ] APIfying    