defmodule Takso.Dao.Service.UserService do
  alias Takso.Dao.Schema.User
  alias Takso.Repo
  import Ecto.Query

  def create_user(user_param) do
    %User{}
    |> User.changeset(user_param)
    |> Repo.insert()
  end

  def update_user(id, user_param) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_param)
    Repo.update(changeset)
  end

  def delete_user(id) do
    user = get_user(id)
    Repo.delete!(user)
  end

  def get_user(id) do
    Repo.get!(User, id)
  end

  def list_users() do
    query = User |> order_by(asc: :name)
    Repo.all(query)
  end

end
