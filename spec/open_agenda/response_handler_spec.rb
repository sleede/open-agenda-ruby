require 'spec_helper'
require 'open_agenda/response_handler'
require 'hashie'

describe OpenAgenda::ResponseHandler do
  subject(:a) { (Class.new { include OpenAgenda::ResponseHandler }).new }
  let(:body) { Hashie::Mash.new({ data: { message: 'msg', code: 'x' } }) }

  context "success" do
    it { expect(a.handle(body, 200)).to eq(body.data) }
  end

  context "bad request" do
    it { expect { a.handle(body, 400) }.to raise_error(OpenAgenda::BadRequestError) }
  end

  context "not found" do
    it { expect { a.handle(body, 404) }.to raise_error(OpenAgenda::NotFoundError) }
  end

  context "client error" do
    it { expect { a.handle(body, 429) }.to raise_error(OpenAgenda::ClientError) }
    it { expect { a.handle(body, 407) }.to raise_error(OpenAgenda::ClientError) }
  end

  context "server error" do
    it { expect { a.handle(body, 500) }.to raise_error(OpenAgenda::InternalServerError) }
    it { expect { a.handle(body, 501) }.to raise_error(OpenAgenda::ServerError) }
  end
end
