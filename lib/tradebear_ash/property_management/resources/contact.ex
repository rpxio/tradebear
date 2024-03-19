defmodule TradebearAsh.PropertyManagement.Contact do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "contacts"
    repo TradebearAsh.Repo
  end

  code_interface do
    define_for TradebearAsh.PropertyManagement

    define :create, action: :create
    define :associate, action: :update
  end

  actions do
    defaults [:read, :update, :destroy]

    create :create do
      accept [:name, :email, :phone, :address]

      argument :client_id, :uuid do
        allow_nil? false
      end

      change manage_relationship(:client_id, :client, type: :append_and_remove)
    end

    update :associate do
      accept []

      argument :client_id, :uuid do
        allow_nil? false
      end

      change manage_relationship(:client_id, :client, type: :append_and_remove)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string, allow_nil?: false
    attribute :email, :string, allow_nil?: false
    attribute :phone, :string, allow_nil?: false
    attribute :address, :string, allow_nil?: false
  end

  relationships do
    has_many :notes, TradebearAsh.PropertyManagement.Note
    belongs_to :client, TradebearAsh.PropertyManagement.Client
  end
end
