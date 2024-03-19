defmodule TradebearAsh.PropertyManagement.Contact do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "contacts"
    repo TradebearAsh.Repo
  end

  code_interface do
    define_for TradebearAsh.PropertyManagement

    define :create, args: [:destination_client_id, :primary?]
  end

  actions do
    defaults [:read, :update, :destroy]

    create :create do
      accept [:name, :email, :phone, :address]

      argument :destination_client_id, :uuid, allow_nil?: false
      argument :primary?, :boolean, allow_nil?: true, default: false

      manual fn changeset, _ ->
        with {:ok, client_id} <-
               Ash.Changeset.fetch_argument(changeset, :destination_client_id),
             {:ok, primary?} <- Ash.Changeset.fetch_argument(changeset, :primary?),
             {:ok, _} <-
               TradebearAsh.PropertyManagement.ClientContact.create(
                 changeset.data.id,
                 client_id,
                 %{primary_contact: primary?}
               ) do
          {:ok, changeset.data}
        end
      end
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

    many_to_many :clients, TradebearAsh.PropertyManagement.Client do
      through TradebearAsh.PropertyManagement.ClientContact
      source_attribute_on_join_resource :contact_id
      destination_attribute_on_join_resource :client_id
    end
  end
end
