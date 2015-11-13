describe Idcf::Dns::ClientExtensions::Zone do
  include_context "resources"

  describe "#create_zone" do
    let(:response) { client.create_zone(attributes) }

    context "when valid request" do
      let(:attributes) { zone_attributes }
      after { ZONES << response.uuid }

      it do
        expect(response.status).to eq 201
        expect(response.success?).to be_truthy
        expect(response.uuid).not_to be nil
      end
    end

    context "when invalid request with unnecessary attributes" do
      let(:attributes) { zone_attributes( invalid: "" ) }

      it do
        expect{ client.create_zone(attributes) }.to raise_error(Idcf::Dns::UnnecessaryAttribute)
      end
    end

    context "when invalid request with missing attributes" do
      let(:attributes) { zone_attributes.delete_if{ |k, v| k == :default_ttl} }

      it do
        expect{ client.create_zone(attributes) }.to raise_error(Idcf::Dns::MissingAttribute)
      end
    end
  end

  describe "#delete_zone" do
    before { ZONES << client.create_zone(zone_attributes).uuid }
    let(:response) { client.delete_zone(uuid) }
    let(:uuid) { ZONES.pop }

    context "when valid request" do
      it "should succeed" do
        expect(response.status).to eq 200
        expect(response.success?).to be_truthy
      end
    end

    context "when deleting deleted zone" do
      before { client.delete_zone(uuid) }

      it do
        expect{ client.delete_zone(uuid) }.to raise_error(Idcf::Dns::ApiError)
      end
    end
  end

  describe "#get_zone" do
    before { ZONES << client.create_zone(zone_attributes).uuid }
    let(:response) { client.get_zone(uuid) }

    context "when valid request" do
      let(:uuid) { ZONES.last }

      it do
        expect(response.status).to eq 200
        expect(response.success?).to be_truthy
        expect(response.body).to be_an_instance_of(Hash)
      end
    end
  end

  describe "#list_zones" do
    let(:response) { client.list_zones }

    context "when valid request" do
      it do
        expect(response.status).to eq 200
        expect(response.success?).to be_truthy
        expect(response.body).to be_an_instance_of(Array)
      end
    end
  end

  describe "#update_zone" do
    let(:response) { client.update_zone(uuid, attributes) }

    context "when valid request" do
      let(:uuid) { ZONES.last }
      let(:attributes) { { description: "Updated description." } }

      it do
        expect(response.status).to eq 200
        expect(response.success?).to be_truthy
      end
    end
  end
end
