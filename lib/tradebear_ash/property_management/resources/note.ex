defmodule TradebearAsh.PropertyManagement.Note do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "notes"
    repo TradebearAsh.Repo
  end

  code_interface do
    define_for TradebearAsh.PropertyManagement

    define :create, action: :create
    define :associate_with_client, action: :update
  end

  actions do
    defaults [:read, :update, :destroy]

    create :create do
      accept [:data]

      argument :client_id, :uuid
      argument :contact_id, :uuid
      argument :property_id, :uuid

      change manage_relationship(:client_id, :client, type: :append_and_remove)
      change manage_relationship(:contact_id, :contact, type: :append_and_remove)
      change manage_relationship(:property_id, :property, type: :append_and_remove)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :data, :string, allow_nil?: false
  end

  relationships do
    belongs_to :client, TradebearAsh.PropertyManagement.Client
    belongs_to :contact, TradebearAsh.PropertyManagement.Contact
    belongs_to :property, TradebearAsh.PropertyManagement.Property
  end
end
