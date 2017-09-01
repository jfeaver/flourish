defmodule FlourishWeb.PageView do
  use FlourishWeb, :view

  def welcome_user_message(conn) do
    if Map.has_key?(conn.assigns, :current_user) do
      render("welcome_user_message.html", user: conn.assigns.current_user)
    else
      "Sorry, you don't seem to be logged in but we might not have this right..."
    end
  end
end
