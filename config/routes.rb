Rails.application.routes.draw do
  post "/schedule", to: "schedules#create"
end
