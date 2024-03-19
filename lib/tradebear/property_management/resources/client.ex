defmodule Tradebear.PropertyManagement.Client do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "clients"
    repo Tradebear.Repo
  end

  code_interface do
    define_for Tradebear.PropertyManagement

    define :create, action: :create
    define :get_all, action: :read
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string, allow_nil?: false
    attribute :billing_address, :string, allow_nil?: false
  end

  relationships do
    has_many :notes, Tradebear.PropertyManagement.Note

    has_many :contacts, Tradebear.PropertyManagement.ClientContact do
      destination_attribute :client_id
    end

    has_one :primary_contact, Tradebear.PropertyManagement.ClientContact do
      filter expr(primary_contact)
      destination_attribute :client_id
    end

    has_many :properties, Tradebear.PropertyManagement.Property
  end
end
