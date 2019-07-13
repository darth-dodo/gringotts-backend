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


## Lame API Docs

### Signup
- URL: POST /signup/
```json
{
  "email": "demo@gg.com",
  "password": "demouserfordemo"
}
```

### Login to extract the JWT
- URL: POST /auth/login/
```json
{
  "email": "demo@gg.com",
  "password": "demouserfordemo"
}
```

### Account
- URL: GET /accounts/
- URL: GET /accounts/id/
- URL: POST /accounts/

```json
{
  "name": "Salary"
}
```

```json
{
  "name": "Cash Wallet"
}
```
- URL: PUT /accounts/id/

```json
{
  "name": "Wallet"
}
```

- URL: POST /accounts/1/toggle-favorite
```
No payload
```


### Category
- URL: GET /categories/
- URL: GET /categories/id/

**Gotta remove eligible_mode**
- URL: POST /categories/

```json
{
  "name": "Salary",
  "eligible_mode": "creditable"
}
```

```json
{
  "name": "Commute",
  "eligible_mode": "debitable"
}
```

```json
{
  "name": "Cash Transfer",
  "eligible_mode": "creditable",
  "category_type": "internal_transfer"
}
```
- URL: PUT /categories/id/
```json
{
  "name": "Cash Refill"
}
```

- URL: POST /categories/1/toggle-favorite
```
No payload
```


### Expense Log
- URL: POST /expense_logs/

```json
{
  "account_id":4,
  "category_id":3,
  "amount":5000,
  "mode": "credit",
  "note":"Salary Credit"
}
```

```json
{
  "user_id":7,
  "account_id":4,
  "destination_account_id": 3,
  "category_id":2,
  "amount":500,
  "mode": "debit",
  "note":"Wallet refill from new salary"
}
```
- URL: POST /expense_logs/1/toggle-favorite
```
No payload
```


### Internal Transfer Log
- URL: GET /internal-transfer-logs/
- URL: GET /internal-transfer-logs/id/

--


## ToDo
- [ ] Specs setup
- [ ] Swagger
- [ ] Async using 
- [ ] Heroku add ons
    - [ ] Database backup
    - [ ] Scheduler
    - [ ] Airbrake
- [ ] YAML based config
- [x] APIfying
- [ ] Polymorphic demo:
    - [x] Likeable (custom)
    - [ ] Taggable (gem)
- [ ] OAuth
- [x] PaperTrail
- [ ] Fast Json API
- [ ] Query Optimization
- [ ] Refactor part 1
- [ ] CSV downloads
- [ ] Filters (based on FE)
