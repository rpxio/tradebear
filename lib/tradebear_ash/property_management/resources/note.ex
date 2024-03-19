defmodule TradebearAsh.PropertyManagement.Note do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "notes"
    repo TradebearAsh.Repo
  end

  code_interface do
    define_for TradebearAsh.PropertyManagement

    define :create_client_note, action: :create
    define :create_contact_note, action: :create
    define :create_property_note, action: :create
  end

  actions do
    defaults [:create, :read, :update, :destroy]

    create :create_client_note do
      accept [:data]

      argument :client_id, :uuid, allow_nil?: false

      change manage_relationship(:client_id, :client, type: :append_and_remove)
    end

    create :create_contact_note do
      accept [:data]

      argument :contact_id, :uuid, allow_nil?: false

      change manage_relationship(:contact_id, :contact, type: :append_and_remove)
    end

    create :create_property_note do
      accept [:data]

      argument :property_id, :uuid, allow_nil?: false

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
