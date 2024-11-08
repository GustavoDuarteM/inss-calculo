# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@rails/actioncable", to: "actioncable.esm.js"
pin 'inputmask', to: 'https://ga.jspm.io/npm:inputmask@5.0.8/dist/inputmask.js'
pin "uuid" # @11.0.2
pin "chart.js", to: "https://cdn.skypack.dev/chart.js"
pin "@kurkle/color", to: "https://cdn.skypack.dev/@kurkle/color"
