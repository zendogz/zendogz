class Permission < Struct.new(:user)
  def can?(controller, action)
    if user
      return true if user.role?(:admin)
      return true if controller == "people" && action.in?(%w[show edit update])
      if user.role?(:owner)
        return true if controller == "dogs"
        return true if controller == "notes"
      end
    end
    return true if controller == "pages"
    return true if controller == "sessions"
    return true if controller == "people" && action.in?(%w[new create])
    return true if controller == "testimonials" && action.in?(%w[index show])
    return true if controller == "courses" && action.in?(%w[index show])
    false
  end
end