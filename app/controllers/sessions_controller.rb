class SessionsController < Clearance::SessionsController
  private

  def url_after_create
    Service::Event::User.new(current_user).signed_in
    super
  end

end
