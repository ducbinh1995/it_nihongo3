module UsersHelper
  def display_avatar user, size, c = ""
    unless user.avatar.url.nil?
      image_tag user.avatar.url
    else
      if user.gender == "male"
        image_tag "male.png", :size => size, :class => c
      else
        image_tag "female.png", :size => size, :class => c
      end
     end
  end
end
