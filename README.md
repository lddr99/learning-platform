<img src="https://travis-ci.com/lddr99/learning-platform.svg?branch=master" alt="build:passed">

# Learning Platform

## Requirements
- Ruby 2.6.5
- PostgreSQL

## Initial Project
1. bundler
2. run rake db:migrate
3. run rake db:seed




## Restful API Docs
### **Authorization**
``` ruby
  POST  `/api/v1/auth`
  POST  `/api/v1/auth/sign_in`
DELETE  `/api/v1/auth/sign_out` # delete token
```

Token Auth Headers
- access-token, token-type, client, expiry, uid


---

### Admin Operations
- Domain `/api/admin`

**Course**
- title, is_available, category_id, duration_of_days, description, url, price, currency_id

```ruby
   GET  `/api/admin/courses`
  POST  `/api/admin/courses`
   PUT  `/api/admin/courses/:id`
DELETE  `/api/admin/courses/:id`
```

**Category** - course category
```ruby
   GET  `/api/admin/categories`
```


**Currency** - simple currency rates
```ruby
   GET  `/api/admin/currencies`
```


---

### User Operation
- Domain `/api/v1`

**Subscription** - user subscription records
```ruby
# subscribe course
  POST  `/api/v1/subscriptions` # required course_id
  
# get user subscriptions
   GET  `/api/v1/subscriptions`
   
# filter by category_ids
   GET  `/api/v1/subscriptions?category_ids[]=1,category_ids[]=2`

# select active subscriptions
   GET  `/api/v1/subscriptions?is_active=true`
```
---


## TODO
- [ ] separate font-end view components (`/management/course-editor`)
