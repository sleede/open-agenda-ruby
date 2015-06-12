require 'spec_helper'
require 'open_agenda/response_handler'

describe OpenAgenda::ResponseHandler do
  subject(:a) { (Class.new { include OpenAgenda::ResponseHandler }).new }

  context "success" do
    it { expect(a.handle('data', 200)).to eq('data') }
  end

  context "bad request" do
    it { expect { a.handle('data', 400) }.to raise_error(OpenAgenda::BadRequestError) }
  end

  context "not found" do
    it { expect { a.handle('data', 404) }.to raise_error(OpenAgenda::NotFoundError) }
  end

  context "client error" do
    it { expect { a.handle('data', 429) }.to raise_error(OpenAgenda::ClientError) }
    it { expect { a.handle('data', 407) }.to raise_error(OpenAgenda::ClientError) }
  end

  context "server error" do
    it { expect { a.handle('data', 500) }.to raise_error(OpenAgenda::InternalServerError) }
    it { expect { a.handle('data', 501) }.to raise_error(OpenAgenda::ServerError) }
  end
end
