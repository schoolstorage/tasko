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

command -> template -> module -> schema -> table -> fields
mix phx.gen.html Billing Payment payments type description:text initial_balance:float

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

## list all routes
mix phx.routes

## mvc works based on convention
1. lib/takso_web/router.ex
   1. resources "/users", UserController
2. lib/takso_web/controllers/user_controller.ex
3. lib/takso_web/views/user_view.ex
4. lib/takso_web/templates/user ( a package for the ui templates )


## run bdd test
mix white_bread.run




MIX_ENV=test mix ecto.migrate
MIX_ENV=test mix run priv/repo/seeds.exs
MIX_ENV=test  mix white_bread.run
MIX_ENV=test mix phx.server
:timer.sleep(5000)
*************************************************************************************************************


Feature: Rent a bike
As a customer
Such that I go to a docking station
I want to rent a bike

Scenario: Renting via Bike-Sharing' web page (with confirmation)
Given the following dock stations are in service
| dock_location | lat	        | lon         | total_parking_slots | available_bikes  |
| AHHAA         | 58.37690838 | 26.73315958 | 12                  | 2                |
Given the following bikes are available to rent
| bike_code | bike_type	        | status         | dock_location |
| B0001     | classic 	        | available      | AHHAA         |
| B0002     | electric 	        | available      | AHHAA         |
And I open Bike-Sharing' web page
And I want to select dock station "AHHAA"
And I want to select bike "B0001"
When I summit the rent request
Then I should receive a confirmation message

*************************************************************************************************************




given_ ~r/^the following dock stations are in service$/, fn state, %{table_data: table} ->
table
|> Enum.map(fn dock -> DockStation.changeset(%DockStation{}, dock) end)
|> Enum.each(fn changeset -> Repo.insert!(changeset) end)
{:ok, state}
end

given_ ~r/^the following bikes are available to rent$/, fn state, %{table_data: table} ->
Enum.each(table, fn(row) ->
dock = Repo.get_by(DockStation, dock_location: row.dock_location)
bike_changeset = Bike.changeset(%Bike{}, %{bike_code: row.bike_code, bike_type: row.bike_type, status: row.status})
bike = Repo.insert!(bike_changeset)
Repo.insert!(%DockedBike{dock_station_id: dock.id, bike_id: bike.id})
end)
{:ok, state}
end

and_ ~r/^I open Bike-Sharing' web page$/, fn state ->
navigate_to "/rent"
{:ok, state}
end

and_ ~r/^I want to select dock station "(?<argument_one>[^"]+)"$/,
fn state, %{argument_one: argument_one} ->
fill_field({:id, "txtDockName"}, argument_one)
click({:id, "btnDockName"})
{:ok, state |> Map.put(:dock_location, argument_one)}
end

and_ ~r/^I want to select bike "(?<argument_one>[^"]+)"$/,
fn state, %{argument_one: argument_one} ->
fill_field({:id, "txtBikeName"}, argument_one)
click({:id, "btnBikeName"})
{:ok, state |> Map.put(:bike_code, argument_one)}
end

when_ ~r/^I summit the rent request$/, fn state ->
click({:id, "submit_button"})
{:ok, state}
end

then_ ~r/^I should receive a confirmation message$/, fn state ->
assert visible_in_page? ~r/Your bike has been unlocked!/
#assert visible_in_element?({:css, ".alert-info:first-child"}, "Your bike has been unlocked!")
{:ok, state}
end
