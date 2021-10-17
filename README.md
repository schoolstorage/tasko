# Takso
```shell

https://serokell.io/blog/introduction-to-phoenix

# create new project
mix phx.new takso

# create database ( config/dev.exs )
mix ecto.create

# start dev server ( default: http://localhost:4000 )
mix phx.server

# create migration
mix ecto.gen.migration user

# run migrations
mix ecto.migrate

# create schema ( dto, manual is better )
mix phx.gen.schema Accounts.User users name

# run mix 
iex -S mix

# try services in console
UserService.list_users()
UserService.create_user(%{"name" => "bang bang", "username" => "tango", "password" => "bingo"})
UserService.update_user(3, %{"name" => "bang bang x", "username" => "tangox", "password" => "bingox"})
UserService.delete_user(3)
```
