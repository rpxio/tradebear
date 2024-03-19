alias Tradebear.PropertyManagement
alias Tradebear.PropertyManagement.Client
alias Tradebear.PropertyManagement.Contact
alias Tradebear.PropertyManagement.Note
alias Tradebear.PropertyManagement.Property

client = Client.create!(%{name: "Jason", billing_address: "1234 South st, Tulsa, OK 74134"})

contact =
  Contact.create!(%{
    name: "Jason Noonan",
    phone: "918-551-9381",
    address: "1234 South st, Tulsa, OK 74134",
    email: "jason.t.noonan@gmail.com",
    client_id: client.id
  })

property = Property.create!(%{address: "1234 South st, Tulsa, OK 74134", client_id: client.id})

client_note = Note.create!(%{data: "This client is the coolest!", client_id: client.id})

contact_note =
  Note.create!(%{data: "I'd contact this guy, if you know what I mean...", contact_id: contact.id})

property_note =
  Note.create!(%{data: "Is that your boulder? That's a nice boulder.", property_id: property.id})

defmodule Shell do
  def full_client(client) do
    PropertyManagement.load(client, [:notes, contacts: [:notes], properties: [:notes]])
  end
end
