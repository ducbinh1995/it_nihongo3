require 'rails_helper'

RSpec.describe "books/edit", type: :view do
  before(:each) do
    @book = assign(:book, Book.create!(
      :title => "MyString",
      :author => "MyString",
      :image => "MyString",
      :isbn => "MyString",
      :publisher => "MyString",
      :categoryid => 1
    ))
  end

  it "renders the edit book form" do
    render

    assert_select "form[action=?][method=?]", book_path(@book), "post" do

      assert_select "input[name=?]", "book[title]"

      assert_select "input[name=?]", "book[author]"

      assert_select "input[name=?]", "book[image]"

      assert_select "input[name=?]", "book[isbn]"

      assert_select "input[name=?]", "book[publisher]"

      assert_select "input[name=?]", "book[categoryid]"
    end
  end
end
