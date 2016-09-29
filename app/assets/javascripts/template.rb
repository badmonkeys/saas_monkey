copy_file 'app/assets/javascripts/application.coffee'
run 'rm app/assets/javascripts/application.js'

copy_file 'app/assets/javascripts/components.coffee'
template 'app/assets/javascripts/components/landing_page_content.js.jsx.coffee.tt'
template 'app/assets/javascripts/components/pricing_page_content.js.jsx.coffee.tt'
template 'app/assets/javascripts/components/about_page_content.js.jsx.coffee.tt'

create_file 'app/assets/javascripts/channels/channel.js', ''

