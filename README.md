# README

Steps  necessary to get the application up and running.

Things you may want to cover:

* Install Ruby `3.0.0` and Rails `7.0.1` using RVM

```
\curl -sSL https://get.rvm.io | bash -s stable --rails
```
```
  bundle install
  rails db:setup
```
and finally, run the server

```
rails s
```