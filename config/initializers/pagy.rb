# Optionally override some pagy default with your own in the pagy initializer
Pagy::DEFAULT[:limit] = 40 # items per page
Pagy::DEFAULT[:size]  = 9  # nav bar links
# Require a CSS framework extra in the pagy initializer (e.g. bootstrap)
require 'pagy/extras/bootstrap'
# Better user experience handled automatically
require 'pagy/extras/overflow'
Pagy::DEFAULT[:overflow] = :last_page
p "Pagy initializer loaded"