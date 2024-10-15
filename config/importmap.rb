# config/importmap.rb

# Pin npm packages by running ./bin/importmap

pin "application"
pin "@rails/ujs", to: "rails-ujs.js"
pin "@hotwired/turbo-rails", to: "turbo.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-webpack-helpers", to: "stimulus-webpack-helpers.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers" 
pin "packs/application", to: "pack.js"
pin "shelter_data", to: "shelter_data.js"
pin "serviceworker-controller", to: "serviceworker-controller.js"
pin "shelter_loader", to: "shelter_loader.js"
pin "serviceworker", to:"serviceworker.js"