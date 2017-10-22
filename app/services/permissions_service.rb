class PermissionsService
  def initialize(user, controller, action)
    @user       = user || User.new
    @controller = controller
    @action     = action
  end

  def authorized?
    default_routes
    if @user.business_manager?
      business_manager_permissions
    elsif @user.admin?
      admin_permissions
    else
      return false
    end
  end

  def business_manager_permissions
    return true if @controller == 'vendor/items' && @action == (%w(index show edit update))
  end

  def admin_permissions
    return true if @controller == 'admin/base'
    return true if @controller == 'admin/items'
    return true if @controller == 'admin/orders'
    return true if @controller == 'admin/users'
  end

  def default_routes
    return true if @controller == 'items' && @action == (%w(index show))
    return true if @controller == 'tags' && @action == (%w(index show))
    return true if @controller == 'vendors' && @action == (%w(index show))
    return true if @controller == 'orders' && @action == (%w(index show))
    return true if @controller == 'sessions' && @action == (%w(new create destroy))
    return true if @controller == 'cart' && @action == (%w(show))
  end

end
