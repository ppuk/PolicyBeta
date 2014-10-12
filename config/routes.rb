Dir.glob("#{Rails.root.to_s}/config/routes/**/*.rb").each {|route_file| load(route_file)}

PolicyBeta::Application.routes.draw do
  Routes::Admin.draw(self)
  Routes::Api.draw(self)
  Routes::Account.draw(self)
  Routes::Clearance.draw(self)
  Routes::Policy.draw(self)
  Routes::Public.draw(self)
end
