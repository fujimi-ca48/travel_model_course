// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "jquery";
import "jquery-ui"; 
import "./total_spot_items.js"
import "./count.js"
import "./preview.js"
import { Application } from 'stimulus';
import { Autocomplete } from 'stimulus-autocomplete';
const application = Application.start();
application.register('autocomplete', Autocomplete);
