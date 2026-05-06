require 'rails_helper'

RSpec.describe "Api::V1::Results", type: :request do
  describe "POST /api/v1/results" do
    let(:valid_params) do
      {
        student_name: "Prashant",
        subject: "Math",
        marks: 85,
        taken_at: Time.current
      }
    end

    it "creates a new result" do
      expect {
        post "/api/v1/results", params: valid_params
      }.to change(Result, :count).by(1)

      expect(response).to have_http_status(:created)

      json = JSON.parse(response.body)
      expect(json["message"]).to eq("Successfully Saved!!")
    end

    it "returns error for invalid data" do
      invalid_params = {
        student_name: "",
        subject: "",
        marks: 200
      }

      post "/api/v1/results", params: invalid_params

      expect(response).to have_http_status(:unprocessable_entity)

      json = JSON.parse(response.body)
      expect(json["errors"]).to be_present
    end
  end
end