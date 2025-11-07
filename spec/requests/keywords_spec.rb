require 'rails_helper'

RSpec.describe "Keywords", type: :request do
  describe "GET /index" do
    context "unauthenticated user" do
      it "redirects to sign in" do
        get keywords_path

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "authenticated user" do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      it "lists all keywords" do
        keyword_file = create(:keyword_file, user: user)
        keywords = create_list(:keyword, 2, keyword_file: keyword_file)

        get keywords_path

        expect(assigns(:keywords)).to eq(keyword_file.keywords.order(created_at: :desc))
      end

      it "destroys a keyword" do
        keyword_file = create(:keyword_file, user: user)
        keyword = create(:keyword, keyword_file:)

        expect do
          delete keyword_path(keyword)
        end.to change(keyword_file.keywords, :count).by(-1)

        expect(response).to redirect_to keywords_path
      end
    end
  end
end
