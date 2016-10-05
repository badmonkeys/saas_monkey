#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require react
#= require react_ujs
#= require components
#= require_tree .

# Resolves an issue w/ turbolinks 5 and react-rails https://github.com/reactjs/react-rails/issues/607
ReactRailsUJS.handleEvent('turbolinks:before-cache', ()->
    window.ReactRailsUJS.unmountComponents()
)

