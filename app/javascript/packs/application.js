import Rails from '@rails/ujs'
import Turbolinks from 'turbolinks'
import * as ActiveStorage from '@rails/activestorage'
import './utilities/form_hider'
import './utilities/header_color'

Rails.start()
Turbolinks.start()
ActiveStorage.start()
