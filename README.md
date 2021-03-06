# Takso
```elixir

https://serokell.io/blog/introduction-to-phoenix

# create new project
mix phx.new takso

# update dependencies
mix deps.get
mix deps.compile

# create database ( config/dev.exs )
mix ecto.create

# create migration
mix ecto.gen.migration user

# run migrations
mix ecto.migrate

# create schema ( dto, manual is better )
mix phx.gen.schema Accounts.User users name

# run mix 
iex -S mix

# try services in console
alias Takso.Dao.Service.UserService
UserService.list_users()
UserService.create_user(%{"name" => "bang bang", "username" => "tango", "password" => "bingo"})
UserService.update_user(3, %{"name" => "bang bang x", "username" => "tangox", "password" => "bingox"})
UserService.delete_user(3)

# start dev server ( default: http://localhost:4000 )
mix phx.server

```

## mvc works based on convention
1. lib/takso_web/router.ex
   1. resources "/users", UserController
2. lib/takso_web/controllers/user_controller.ex
3. lib/takso_web/views/user_view.ex
4. lib/takso_web/templates/user ( a package for the ui templates )
