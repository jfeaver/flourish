defmodule Flourish.Authentication.EnsureAuthenticated do
  @claims %{typ: "access"}

  use Guardian.Plug.Pipeline, otp_app: :flourish,
                              module: Flourish.Authentication,
                              error_handler: Flourish.Authentication.AuthErrorHandler

  plug Guardian.Plug.VerifySession, claims: @claims
  plug Guardian.Plug.VerifyHeader, claims: @claims, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, ensure: true
end
