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
  "account_id":1,
  "category_id":1,
  "amount":50000,
  "mode": "credit",
  "note":"Salary Credit",
  "tag_list": ["paisa", "paishe"]
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
  "note":"Wallet refill from new salary",
  "tag_list": ["oops"]
}
```

- URL: PUT /expense_logs/1/
```json
{
  "tag_list": ["chai, samosa"],
  "note": "Money for snacks!"
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
