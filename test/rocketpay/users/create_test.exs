defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User

  describe "call/1" do
    test "when all params are valid, return un user" do
      params = %{
        name: "Fabíola",
        password: "123456",
        nickname: "fabi",
        email: "fabi@banana.com",
        age: 22
      }

      {:ok, %User{id: user_id}} = Rocketpay.create_user(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Fabíola", age: 22, id: ^user_id} = user
    end

    test "when there are invalid params, return un user" do
      params = %{
        name: "Fabíola",
        nickname: "fabi",
        email: "fabi@banana.com",
        age: 15
      }

      {:error, changeset} = Rocketpay.create_user(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
