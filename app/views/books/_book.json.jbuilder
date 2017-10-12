json.extract! book, :id, :title, :author, :image, :isbn, :publisher, :publish-date, :categoryid, :created_at, :updated_at
json.url book_url(book, format: :json)
