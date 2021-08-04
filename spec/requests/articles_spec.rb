require 'rails_helper'

describe Api::ArticlesController, type: :request do
  before do
    articles = create_list(:article, 50)
    articles.each do |article|
      create_list(:comment, 3, article: article)
    end
  end

  let(:headers) do
    { "Accept" => "application/json" }
  end

  describe 'GET /api/articles' do
    it 'returns articles' do
      get api_articles_path, headers: headers
      expect(response).to have_http_status(:ok)
    end

    context 'with paginate params' do
      it 'returns paginated articles' do
        get api_articles_path(per_page: 10, page: 2), headers: headers
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
