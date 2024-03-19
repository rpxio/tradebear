defmodule Tradebear.PropertyManagement do
  use Ash.Api

  resources do
    resource Tradebear.PropertyManagement.Client
    resource Tradebear.PropertyManagement.ClientContact
    resource Tradebear.PropertyManagement.Contact
    resource Tradebear.PropertyManagement.Note
    resource Tradebear.PropertyManagement.Property
  end
end
