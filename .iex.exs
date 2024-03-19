alias Tradebear.PropertyManagement
alias Tradebear.PropertyManagement.Client
alias Tradebear.PropertyManagement.Contact
alias Tradebear.PropertyManagement.Note
alias Tradebear.PropertyManagement.Property

client = Client.create!(%{name: "Jason", billing_address: "1234 South st, Tulsa, OK 74134"})

primary_contact =
  Contact.create!(%{
    name: "Jason Noonan",
    phone: "555-123-4567",
    address: "1234 South st, Tulsa, OK 74134",
    email: "jason.t.noonan@gmail.com"
  })
  |> Contact.link_to_client!(client.id, true)

other_contact =
  Contact.create!(%{
    name: "Haley Noonan",
    phone: "555-456-7890",
    address: "1234 South st, Tulsa, OK 74134",
    email: "lessthan4squard@gmail.com"
  })
  |> Contact.link_to_client!(client.id, false)

property = Property.create!(%{address: "1234 South st, Tulsa, OK 74134", client_id: client.id})

client_note = Note.create!(%{data: "This client is the coolest!", client_id: client.id})

contact_note =
  Note.create!(%{
    data: "I'd contact this guy, if you know what I mean...",
    contact_id: primary_contact.id
  })

property_note =
  Note.create!(%{data: "Is that your boulder? That's a nice boulder.", property_id: property.id})

defmodule Shell do
  def full_client(client) do
    PropertyManagement.load!(client, [:notes, :contacts, :properties])
  end

  def full_contacts(contact) do
    PropertyManagement.load!(contact, [:notes, :clients])
  end

  def full_property(property) do
    PropertyManagement.load!(property, [:notes, :client])
  end
end
