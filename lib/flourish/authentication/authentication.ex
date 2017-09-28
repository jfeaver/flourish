defmodule Flourish.Authentication do
  use Guardian, otp_app: :flourish

  alias Flourish.Repo
  alias Flourish.Accounts.User

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  # def subject_for_token(_, _) do
  #   {:error, :reason_for_error}
  # end

  def resource_from_claims(claims) do
    {:ok, Repo.get(User, claims["sub"])}
  end

  # def resource_from_claims(_claims) do
  #   {:error, :reason_for_error}
  # end
end
