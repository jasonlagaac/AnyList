module ItemsHelper
  def event_owned_by_current_user?(item)
    current_user.events.find_by_id(item.event_id)
  end
end
