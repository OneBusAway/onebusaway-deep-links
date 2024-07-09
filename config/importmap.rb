# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@tailwindcss/forms", to: "@tailwindcss--forms.js" # @0.5.7
pin "mini-svg-data-uri" # @1.4.4
pin "picocolors" # @1.0.0
pin "tailwindcss/colors", to: "tailwindcss--colors.js" # @3.4.3
pin "tailwindcss/defaultTheme", to: "tailwindcss--defaultTheme.js" # @3.4.3
pin "tailwindcss/plugin", to: "tailwindcss--plugin.js" # @3.4.3
pin "@rails/request.js", to: "@rails--request.js.js" # @0.0.8
pin "@stimulus-components/sortable", to: "@stimulus-components--sortable.js" # @5.0.1
pin "sortablejs" # @1.15.2
