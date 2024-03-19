defmodule TradebearAsh.PropertyManagement.Client do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "clients"
    repo TradebearAsh.Repo
  end

  code_interface do
    define_for TradebearAsh.PropertyManagement

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
    has_many :notes, TradebearAsh.PropertyManagement.Note

    has_many :contacts, TradebearAsh.PropertyManagement.ClientContact do
      destination_attribute :client_id
    end

    has_one :primary_contact, TradebearAsh.PropertyManagement.ClientContact do
      filter expr(primary_contact)
      destination_attribute :client_id
    end

    has_many :properties, TradebearAsh.PropertyManagement.Property
  end
end
