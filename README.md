# Takso
```elixir

https://serokell.io/blog/introduction-to-phoenix

# create new project
mix phx.new takso

# update dependencies
mix deps.get
mix deps.compile


# create database ( config/dev[test].exs )
MIX_ENV=test
mix ecto.create

# create migration
mix ecto.gen.migration user

# run migrations
mix ecto.migrate

# populate with seeds
mix run priv/repo/seeds.exs

# create schema ( dto, manual is better )
mix phx.gen.schema Accounts.User users name

# run mix 
iex -S mix
recompile()

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
# list all routes: mix phx.routes
1. lib/takso_web/router.ex
   1. resources "/users", UserController
2. lib/takso_web/controllers/user_controller.ex
3. lib/takso_web/views/user_view.ex
4. lib/takso_web/templates/user ( a package for the ui templates )
