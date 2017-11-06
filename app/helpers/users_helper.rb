module UsersHelper
  def display_avatar user, size
    unless user.avatar.url.nil?
      image_tag user.avatar.url
    else
      if user.gender == "male"
        image_tag "male.png", :size => size
      else
        image_tag "female.png", :size => size
      end
     end
  end
end
