# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "Pages requests", type: :request do
  let(:page) { Mcm::Page.create! name: "Foo", active: true }

  describe "localized routes" do
    context "when a page has only one route" do
      before do
        page.routes.create! locale: :en, value: "/example"
      end

      it "visiting it leads to the page" do
        get "/example"
        expect(response).to have_http_status :ok

        get "/ejemplo" # Some other route
        expect(response).to have_http_status :not_found
      end
    end

    context "when a page has multiple routes" do

      before do
        page.routes.create! locale: :en, value: "/example"
        page.routes.create! locale: :es, value: "/ejemplo"
      end

      it "visiting both leads to the same page" do
        get "/example"
        expect(response).to have_http_status :ok

        get "/ejemplo"
        expect(response).to have_http_status :ok
      end
    end
  end
end
