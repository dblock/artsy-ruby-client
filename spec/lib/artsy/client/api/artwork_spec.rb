require 'spec_helper'

describe Artsy::Client::API::Artwork do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#artwork" do
    before do
      stub_get("/api/v1/artwork/andy-warhol-skull").to_return(
        body: fixture("artwork.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns artwork" do
      artwork = @client.artwork('andy-warhol-skull')
      expect(a_get("/api/v1/artwork/andy-warhol-skull")).to have_been_made
      expect(artwork).to be_an Artsy::Client::Domain::Artwork
      expect(artwork.title).to eq "Skull"
      expect(artwork.artist.name).to eq "Andy Warhol"
    end
  end
  describe "#recently_published_artworks" do
    before do
      stub_get("/api/v1/artworks/new").to_return(
        body: fixture("artworks.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns artwork" do
      artworks = @client.recently_published_artworks
      expect(a_get("/api/v1/artworks/new")).to have_been_made
      expect(artworks).to be_an Array
      expect(artworks.size).to eq 20
      expect(artworks.first.title).to eq "Coiffeuse"
    end
  end
  describe "#create_artwork" do
    before do
      stub_post("/api/v1/artwork").to_return(
        body: fixture("artwork.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns artwork" do
      artwork = @client.create_artwork(title: 'Mona Lisa')
      expect(a_post("/api/v1/artwork")).to have_been_made
      expect(artwork).to be_an(Artsy::Client::Domain::Artwork)
      expect(artwork.title).to eq('Skull')
    end
  end
  describe "#update_artwork" do
    before do
      stub_put("/api/v1/artwork/andy-warhol-skull").to_return(
        body: fixture("artwork.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns artwork" do
      artwork = @client.update_artwork('andy-warhol-skull', title: 'Marilyn')
      expect(a_put("/api/v1/artwork/andy-warhol-skull")).to have_been_made
      expect(artwork).to be_an(Artsy::Client::Domain::Artwork)
      expect(artwork.title).to eq('Skull')
    end
  end
  describe "#update_artwork_inventory" do
    before do
      stub_put("/api/v1/artwork/andy-warhol-skull/inventory").to_return(
        body: fixture("artwork_inventory.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns inventory for an artwork" do
      artwork_inventory = @client.update_artwork_inventory('andy-warhol-skull')
      expect(a_put("/api/v1/artwork/andy-warhol-skull/inventory")).to have_been_made
      expect(artwork_inventory).to be_an Artsy::Client::Domain::Inventory
      expect(artwork_inventory.count).to eq 1
    end
  end
end
