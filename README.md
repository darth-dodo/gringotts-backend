# Gringotts - Personal Finance Tracker

# ![boatload-of-money](https://media.giphy.com/media/VPnTqJLUwCv60/giphy.gif)

## Index
- [Summary](#summary)
- [Installation](#installation)
- [Demo](#demo)
- [API Documentation](#api-documentation)
- [Educational Resources](#educational-resources)
- [Future Scope](#future-scope)
- [Feature Pipeline](#feature-pipeline)

## Summary

[Gringotts](https://harrypotter.fandom.com/wiki/Gringotts_Wizarding_Bank) is a personal expense tracker built using [Ruby](https://www.ruby-lang.org/en/), [Ruby on Rails](https://rubyonrails.org/) and [React](https://reactjs.org/). This repository stores the code for the Backend for the project. The Frontend code base can be found [over here]().

The problem this project tries to solve is that of building a personal application for managing one's expenses. The technical goals of this project was to learn best practices and implement production grade Rails and React application which can be consumed with locally or deployed on a PaaS such as [Heroku](https://www.heroku.com) or [AWS](https://aws.amazon.com).

**The project is heavily inspired by [You Need A Budget](https://www.youneedabudget.com/) and [Walnut](http://www.getwalnut.com/) but has a pro privacy stance i.e. you are in direct control of your data.**

The expense management follows the age old paradigm of the [Envelope Budgeting System](https://www.moneycrashers.com/envelope-budgeting-system/) where you create outflow buckets. Categorical expense are made using these buckets.

For example, you might have three *spending* buckets such as Recreation, Groceries and Self Development. At the start of the cycle, you may credit funds from another bucket, say Salary, and consume/debit funds from these buckets in the form of Expenses eg. Yoga Class (Self Dev bucket), Watching a play (Recreation), Eggs and Ham (Groceries).

You can create Internal Transfer between these buckets as well, for example, I might have two buckets, Salary and Cash. I can do an internal from Salary to Cash to replenish my cash reservers.

Future scope includes using some light weight ML modeling such as [K Means](https://en.wikipedia.org/wiki/K-means_clustering) or [Multiple Regression](https://en.wikipedia.org/wiki/Linear_regression#Simple_and_multiple_linear_regression) to provide preemptive insights of expenses and visualizations using [Pandas](https://pandas.pydata.org/)/[Bokeh](https://bokeh.pydata.org/en/latest/)/[Seaborn](https://seaborn.pydata.org/)

In case of any questions, queries or suggestions please reach out to @abhn or @darth-dodo.

Cheers!

![everyday-i-am-dumblin](https://media.giphy.com/media/emITthtRQb5ok/source.gif)

---

## Installation
### Local instructions
- Make sure you have a [Postgres](http://postgresguide.com/) version greater than 9.6
- Clone the repo
- Use [RVM](https://rvm.io/) to install and set ruby to version 2.6.0
- Run `bundle install`
- Create development postgres db using the command `createdb gringotts_dev` as mentioned in the `database.yml`
- Run `rake db:migrate` to create all the database objects in your local db
- Run `rake db:seed` to create the a couple of users
    - Admin User
      - Username: admin@gringotts.com
      - Password: `get_rich_or_die_codin`
    - Demo User
      - Username: demo@gringotts.com,
      - Password: `demo-user-for-sandbox`
- Run the local server using the command `rails s`
- Hop on to the site and go to `<your-localhost-with-port>/admin`
- Use the above credentials to log into the admin panel
- Have fun tinkering around!

### Heroku
- TBD

## Demo
- The Backend sandbox can be accessed using [Active Admin](https://github.com/activeadmin/activeadmin) at [https://gringotts-backend.herokuapp.com/admin](https://gringotts-backend.herokuapp.com/admin)
- The high level Dashboard can be viewed over [here](https://gringotts-backend.herokuapp.com/admin/dashboard) using Active Admin interface
- Deeper Data Analytics and SQL exploration can be done over a **[Metabase]** instance deployed on Heroku at [https://gringotts-demo-metabase.herokuapp.com/](https://gringotts-demo-metabase.herokuapp.com/) using the following credentials
  - Username: demo@gringotts.com
  - Password: `demo-user-for-sandbox123`
- [WIP] The sandbox app is hosted at [https://gringotts.netlify.com](https://gringotts.netlify.com)

## API Documentation
- ~[The Lame API Docs can be found over here](https://github.com/darth-dodo/gringotts-backend/blob/master/LameAPIDocs.md)~
- [API Documentation generated using Postman](https://documenter.getpostman.com/view/8196826/SVSNJnWy?version=latest)

## Educational Resources
- While working on anything, we tend to come across educational resources which help us in getting better and understanding a problem as well as it's solution on a deeper level
- The [Educational Resources](https://github.com/darth-dodo/gringotts-backend/blob/master/EducationalResources.md) file is a place we have listed down the resources we referred to while working on this project for giving a deeper context and through learning to the reader if required.

## Future Scope
- Move it from being a **tracker** to a **manager**
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
- [x] [Swagger/Slate/Postman integration](https://github.com/darth-dodo/gringotts-backend/pull/19)
- [x] [Active Admin setup](https://github.com/darth-dodo/gringotts-backend/pull/22)
- [x] [Airbrake/Sentry](https://github.com/darth-dodo/gringotts-backend/pull/25)
- [x] Heroku add ons
    - [x] Database backup (Autobus)
    - [x] Scheduler (Heroku Scheduler)
    - [x] Database browser (Trevor)
- [x] [Scheduling using Sidekiq](https://github.com/darth-dodo/gringotts-backend/pull/26)
- [x] [Data Analytics and SQL Exploration using sister Metabase App](https://github.com/darth-dodo/gringotts-backend/pull/28)
- [ ] YAML based config
- [ ] Specs setup
- [ ] OAuth with Google and Github
- [ ] Integration with Netflix's Fast JSON API and response refactoring
- [ ] Code Refactor pair programming with [@abhn](https://github.com/abhn)
- [ ] Query Optimization with [@abhn](https://github.com/abhn)
- [ ] CSV downloads
- [ ] Filters (based on FE)
