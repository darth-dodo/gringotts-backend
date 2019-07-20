# ![Gringotts](https://media.giphy.com/media/rip-city-VPnTqJLUwCv60.gif)

## Index
- [Summary](#summary)
- [Installation](#installation)
- [Demo](#demo)
- [API Documentation](#api-documentation)
- [Education Resources](#education-resources)
- [Future Scope](#future-scope)
- [Feature Pipeline](#feature-pipeline)

## Summary

[Gringotts]() is a personal expense tracker built using [Ruby](), [Ruby on Rails]() and [React](). Future scope includes some light weight ML modelling such as [K Means]() or [Multiple Regression]() to provide preemptive insights of expenses and visualizations using [Pandas]()/[Bokeh]()/[Seaborn]()

The problem this project tries to solve is that of building a personal application for managing one's expenses. The technical goals of this project was to implement production grade Rails and React project which can be consumed with multi tenant or individual deployment.

**The project is heavily inspired by [You Need A Budget]() and [Walnut]() but has a pro privacy stance i.e. you are in direct control of your data.**

The expense management follows the age old paradigm of the Envelop System where you create outflow buckets. Categorical expense are made using these buckets. For example, you might have three buckets such as Recreation, Groceries and Self Development. At the start of the cycle, you may credit funds from another bucket, say Salary, and consume/debit funds from these buckets in the form of Expenses eg. Yoga Class (Self Dev bucket), Watching a play (Recreation), Eggs and Ham (Groceries).

You can create Internal Transfer between these buckets as well, for example, I might have two buckets, Salary and Cash. I can do an internal from Salary to Cash to replenish my cash reservers.

This repository stores the code for the Backend for the project. The Frontend code base can be found [over here].()

In case of any questions or queries please reach out to @abhn or @darth-dodo.

![Cheers!](https://media.giphy.com/media/movie-party-harry-potter-OU1marLMNNtnO.gif)


## Setup
### Local instructions
- Make sure you have a [Postgres]() version greater than 9.6
- Clone the repo
- Use [RVM]() to install and set ruby to version 2.6.0
- Run `bundle install`
- Create development postgres db using the command `createdb gringotts_dev` as mentioned in the `database.yml`
- Run `rake db:migrate` to create all the database objects in your local db
- Run `rake db:seed` to create the first user with the credential
    - Username: admin@gringotts.com
    - Password: `get_rich_or_die_codin`
- Run the local server using the command `rails s`
- Hop on to the site and go to `<your-localhost-with-port>/admin`
- Use the above creds to log into the admin panel
- Have fun tinkering around!

### Heroku
- TBD

## Demo
- The Backend sandbox app is hosted at [gringotts-backend.herokuapp.com](https://gringotts-backend.herokuapp.com)
- Use the above creds listed above to play around.

## API Documentation
- [The Lame API Docs can be found over here](https://github.com/darth-dodo/gringotts-backend/blob/master/LameAPIDocs.md)

## Education Resources
- While working on anything, we tend to come across educational resources which help us in getting better and understanding a problem as well as it's solution on a deeper level
- The [Education Resources](https://github.com/darth-dodo/gringotts-backend/blob/master/EducationalResources.md) file is a place we have listed down the resources we referred to while working on this project for giving a deeper context and through learning to the reader if required.

## Future Scope
- The ideal end state of this project is an automated system which extracts majority of your expense related information using your digital footprint (Bank Statements, SMSes, Emails)
- Using this information help you extract some insights such projected expenses, top spending categories or tags or push you towards goal based savings
- In order to achieve these goals, once we have a stable, simple and straightforward Web App which just takes in expenses and stored them, we will move to some basic visualizations and dashboards where the user can infer insights from the metrics and stats

### Feature Pipeline
- [x] [APIfying](https://github.com/darth-dodo/gringotts-backend/pull/9)
- [x] [Lame API documentation](https://github.com/darth-dodo/gringotts-backend/pull/11)
- [x] [PaperTrail](https://github.com/darth-dodo/gringotts-backend/pull/13)
- [x] Polymorphic demo:
  - [x] [Likeable (custom)](https://github.com/darth-dodo/gringotts-backend/pull/14)
  - [x] [Taggable (gem)](https://github.com/darth-dodo/gringotts-backend/pull/15)
- [ ] Swagger/Slate integration
- [ ] Code Refactor
- [ ] Scheduling using Sidekiq
- [ ] Airbrake
- [ ] Heroku add ons
    - [ ] Database backup
    - [ ] Scheduler
    - [ ] Database browser
- [ ] YAML based config
- [ ] Specs setup
- [ ] OAuth
- [ ] Fast Json API
- [ ] Query Optimization
- [ ] Refactor part 1
- [ ] CSV downloads
- [ ] Filters (based on FE)
