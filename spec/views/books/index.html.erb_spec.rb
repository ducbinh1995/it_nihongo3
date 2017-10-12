require 'rails_helper'

RSpec.describe "books/index", type: :view do
  before(:each) do
    assign(:books, [
      Book.create!(
        :title => "Title",
        :author => "Author",
        :image => "Image",
        :isbn => "Isbn",
        :publisher => "Publisher",
        :categoryid => 2
      ),
      Book.create!(
        :title => "Title",
        :author => "Author",
        :image => "Image",
        :isbn => "Isbn",
        :publisher => "Publisher",
        :categoryid => 2
      )
    ])
  end

  it "renders a list of books" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "Isbn".to_s, :count => 2
    assert_select "tr>td", :text => "Publisher".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
