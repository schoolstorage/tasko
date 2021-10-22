defmodule TaksoWeb.UserController do
  use TaksoWeb, :controller

  alias Takso.Dao.Service.UserService

  def index(conn, _params) do
    render(conn, "index.html", users: UserService.list_users())
  end

  def edit(conn, %{"id" => id}) do
    render(conn, "edit.html", user: UserService.get_user(id))
  end

  def index(conn, _params) do
    render(conn, "index.html", users: UserService.list_users())
  end

end
