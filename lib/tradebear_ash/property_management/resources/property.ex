defmodule TradebearAsh.PropertyManagement.Property do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "properties"
    repo TradebearAsh.Repo
  end

  code_interface do
    define_for TradebearAsh.PropertyManagement

    define :create, action: :create
  end

  actions do
    defaults [:read, :update, :destroy]

    create :create do
      accept [:address]

      argument :client_id, :uuid, allow_nil?: false

      change manage_relationship(:client_id, :client, type: :append_and_remove)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :address, :string, allow_nil?: false
  end

  relationships do
    has_many :notes, TradebearAsh.PropertyManagement.Note
    belongs_to :client, TradebearAsh.PropertyManagement.Client
  end
end
