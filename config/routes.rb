Rails.application.routes.draw do
  post "/schedules", to: "schedules#create"
end
