defmodule TradebearAsh.PropertyManagement do
  use Ash.Api

  resources do
    resource TradebearAsh.PropertyManagement.Client
    resource TradebearAsh.PropertyManagement.ClientContact
    resource TradebearAsh.PropertyManagement.Contact
    resource TradebearAsh.PropertyManagement.Note
    resource TradebearAsh.PropertyManagement.Property
  end
end
