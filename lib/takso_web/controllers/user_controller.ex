defmodule TaksoWeb.UserController do
  use TaksoWeb, :controller

  alias Takso.Dao.Service.UserService

  def index(conn, _params) do
    render(conn, "index.html", users: UserService.list_users())
  end

  def edit(conn, user_id) do
    render(conn, "edit.html", users: UserService.get_user(user_id))
  end

end
