defmodule TradebearAsh.PropertyManagement.ClientContact do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "client_contacts"
    repo TradebearAsh.Repo
  end

  identities do
    identity :unique_link, [:client_id, :contact_id]
  end

  code_interface do
    define_for TradebearAsh.PropertyManagement

    define :create, args: [:contact_id, :client_id]
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      primary? true
      upsert? true
      upsert_identity :unique_link
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :primary_contact, :boolean do
      default false
      allow_nil? true
    end
  end

  relationships do
    belongs_to :client, TradebearAsh.PropertyManagement.Client,
      primary_key?: true,
      allow_nil?: false,
      attribute_writable?: true

    belongs_to :contact, TradebearAsh.PropertyManagement.Contact,
      primary_key?: true,
      allow_nil?: false,
      attribute_writable?: true
  end
end
