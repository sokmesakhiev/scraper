require 'rails_helper'

RSpec.describe "KeywordFiles", type: :request do
  describe "GET /index" do
    context "unauthenticated user" do
      it "redirects to sign in" do
        get keyword_files_path

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "authenticated user" do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      describe 'uploads a file' do
        context "valid file" do
          it "creates a keyword file" do
            file = fixture_file_upload('spec/fixtures/files/keywords.csv', 'text/csv')

            post keyword_files_path, params: { file: }

            expect(assigns(:keyword_file)).to eq(user.keyword_files.last)
          end
        end

        context 'not a csv file' do
          it 'does not create a keyword file' do
            file = fixture_file_upload('spec/fixtures/files/keywords.txt', 'text/plain')

            post keyword_files_path, params: { file: }

            expect(user.keyword_files.count).to eq(0)
            expect(response.body).to include("Invalid file type")
          end
        end

        context 'empty csv file' do
          it 'does not create a keyword file' do
            file = fixture_file_upload('spec/fixtures/files/oversized_keyword.csv', 'text/csv')

            post keyword_files_path, params: { file: }

            expect(user.keyword_files.count).to eq(0)
            expect(response.body).to include("Invalid file size")
          end
        end

        context 'oversized csv file' do
          it 'does not create a keyword file' do
            file = fixture_file_upload('spec/fixtures/files/empty.csv', 'text/csv')

            post keyword_files_path, params: { file: }

            expect(user.keyword_files.count).to eq(0)
          end
        end
      end

      it "lists all uploaded files" do
        create_list(:keyword_file, 2, user: user)

        get keyword_files_path

        expect(assigns(:keyword_files)).to eq(user.keyword_files.order(created_at: :desc))
      end

      it "queries a file" do
        keyword_file = create(:keyword_file, user: user, name: 'foo')
        _other_keyword_file = create(:keyword_file, user: user, name: 'bar')

        get keyword_files_path(query: 'foo')

        expect(assigns(:keyword_files)).to eq([ keyword_file ])
      end

      it "downloads a file" do
        keyword_file = create(:keyword_file, user: user)

        get keyword_file_download_path(keyword_file)

        expect(response.body).to eq(keyword_file.original_file.download)
      end

      it "destroys a file" do
        keyword_file = create(:keyword_file, user: user)

        expect do
          delete keyword_file_path(keyword_file)
        end.to change(user.keyword_files, :count).by(-1)

        expect(response).to redirect_to keyword_files_path
      end

      it "shows a file" do
        keyword_file = create(:keyword_file, user: user)

        get keyword_file_path(keyword_file)

        expect(assigns(:keyword_file)).to eq(keyword_file)
        expect(assigns(:keywords)).to eq(keyword_file.keywords.order(created_at: :desc))
      end
    end
  end
end
