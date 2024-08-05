# Pin npm packages by running ./bin/importmap

pin "application"
pin "@nathanvda/cocoon", to: "@nathanvda--cocoon.js" # @1.2.14
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "myspace", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.3-1/lib/assets/compiled/rails-ujs.js"
