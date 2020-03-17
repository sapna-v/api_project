# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Signup of user -
POST request
localhost:3000/auth/signup
In the body under x-www-form-url-encoded
send name, email and password
You would sign up

Login For user(Only non-disabled user)-
POST request
localhost:3000/auth/login
In the body under x-www-form-url-encoded
send email and password
You would receive Authorization key (valid for 2 hrs)

Get All Users -
GET request
localhost:3000/all_users
In the header send
Content-Type - application/x-www-form-urlencoded
Authorization - Bearer <Authorization key>
You would get all_users

Create User -
POST request
localhost:3000/create_user
In the body under x-www-form-url-encoded
send email, password, name, age(See schema for all attributes)
In the header send
Content-Type - application/x-www-form-urlencoded
Authorization - Bearer <Authorization key>
You would create_user


Delete User -
POST request
localhost:3000/delete_user
In the body under x-www-form-url-encoded
send email
In the header send
Content-Type - application/x-www-form-urlencoded
Authorization - Bearer <Authorization key>
You would delete_user

Edit User -
POST request
localhost:3000/edit_user
In the body under x-www-form-url-encoded
send email and all other fields you want to change(password change only possible for logged in user, not other users)
In the header send
Content-Type - application/x-www-form-url encoded
Authorization - Bearer <Authorization key>
You would delete_user

Sort Users-
GET 'localhost:3000/sort_users'
In the header send
Content-Type - application/x-www-form-urlencoded
Authorization - Bearer <Authorization key>
In the body under x-www-form-url-encoded
send sort_by as key and value as field name
You would get all users sorted by the field

Filter Users-
GET 'localhost:3000/filter_users'
In the header send
Content-Type - application/x-www-form-urlencoded
Authorization - Bearer <Authorization key>
In the body under x-www-form-url-encoded
send filter_by as key and field name as value
send value as key and search_value as value
You would get all users sorted by the field
