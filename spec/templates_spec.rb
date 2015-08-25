describe Idcf::Dns::ClientExtensions::Template, skip: "Currently, templates is experimental resource in REST API" do
  include_context "resources"
  before { TEMPLATES << client.create_template(template_attributes).uuid }

  describe "#create_template" do
    let(:response) { client.create_template(attributes) }
    after { TEMPLATES << response.uuid }

    context "when valid request" do
      let(:attributes) { template_attributes }

      it do
        expect(response.status).to eq 201
        expect(response.success?).to be_truthy
        expect(response.uuid).not_to be nil
      end
    end
  end

  describe "#delete_template" do
    let(:response) { client.delete_template(uuid) }

    context "when valid request" do
      let(:uuid) { TEMPLATES.pop }

      it "should succeed" do
        expect(response.status).to eq 200
        expect(response.success?).to be_truthy
      end
    end
  end

  describe "#get_template" do
    before { TEMPLATES << client.create_template(template_attributes).uuid }
    let(:response) { client.get_template(uuid) }

    context "when valid request" do
      let(:uuid) { TEMPLATES.last }

      it do
        expect(response.status).to eq 200
        expect(response.success?).to be_truthy
        expect(response.body).to be_an_instance_of(Hash)
      end
    end
  end

  describe "#list_templates" do
    let(:response) { client.list_templates }

    context "when valid request" do
      it do
        expect(response.status).to eq 200
        expect(response.success?).to be_truthy
        expect(response.body).to be_an_instance_of(Array)
      end
    end
  end

  describe "#update_template" do
    let(:response) { client.update_template(uuid, attributes) }

    context "when valid request" do
      let(:uuid) { TEMPLATES.last }
      let(:attributes) { { description: "Updated description." } }

      it do
        expect(response.status).to eq 200
        expect(response.success?).to be_truthy
      end
    end
  end
end
