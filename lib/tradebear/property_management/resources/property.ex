defmodule Tradebear.PropertyManagement.Property do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "properties"
    repo Tradebear.Repo
  end

  code_interface do
    define_for Tradebear.PropertyManagement

    define :create, action: :create
    define :get_by_id, args: [:id]
    define :get_all, action: :read
  end

  actions do
    defaults [:read, :update, :destroy]

    create :create do
      accept [:address]

      argument :client_id, :uuid, allow_nil?: false

      change manage_relationship(:client_id, :client, type: :append_and_remove)
    end

    read :get_by_id do
      get? true
      argument :id, :uuid, allow_nil?: false

      filter expr(id == ^arg(:id))
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :address, :string, allow_nil?: false
  end

  relationships do
    has_many :notes, Tradebear.PropertyManagement.Note
    belongs_to :client, Tradebear.PropertyManagement.Client
  end
end
