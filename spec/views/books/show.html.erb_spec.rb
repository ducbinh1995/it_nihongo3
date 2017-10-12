require 'rails_helper'

RSpec.describe "books/show", type: :view do
  before(:each) do
    @book = assign(:book, Book.create!(
      :title => "Title",
      :author => "Author",
      :image => "Image",
      :isbn => "Isbn",
      :publisher => "Publisher",
      :categoryid => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Author/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/Isbn/)
    expect(rendered).to match(/Publisher/)
    expect(rendered).to match(/2/)
  end
end
