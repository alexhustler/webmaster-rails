Webmaster::Rails
================

Tools for building websites on top of Rails + MongoDB + Character


## Redactor (Slate license for $99)

Redactor is used as main WYSIWYG editor in character, but cause of license this could not be included in character itself (or if we got $500 in donations we can buy CMS license — would be awesome!). Here is how you should include this in character, you might want to change *admin* to your instance name if it differs.

In characters ```admin.coffee```:

    #= require redactor

In characters ```admin.scss```:

    @import "redactor";

This makes redactor to be used in **pages**, **posts** apps and **settings** which values are set to be ```html```.


## Nivo Slider

In ```applictaion.coffee```:

    #= require jquery.nivo.slider

In ```application.scss```:

    //= require nivo-slider
    //= require nivo-default


## Mongo Backup

Backup database and upload it to S3 from Cloud66, restore tool is included as well.

Do backup:

    rake mongo:backup

List available backups:

    rake mongo:list_backups

Restore from FILE:

    rake mongo:restore FILE=<filename.tag.gz>


## Photos

TODO: use carrierwave-meta to have sizes for images predefined - no need to wait for image load for Masonry layout.

Photos module with integrated admin and frontend helpers.

Characters javascrip ```admin.coffee```:

    #= require webmaster/character

    # Webmasters default Photo model
    chr.photosModule('Photo')
    # OR
    # Custom model name
    chr.photosModule('Photo', { modelName: 'CustomPhoto' })

Character styles ```admin.scss```:

    @import "webmaster/character";

Styles ```application.scss```:

    @import "grid-gallery";

Javascript ```application.coffee```:

    #= require grid-gallery

    $ ->
      new CBPGridGallery( document.getElementById( 'grid_gallery' ) )

    document.addEventListener "page:load", ->
      new CBPGridGallery( document.getElementById( 'grid_gallery' ) )

Controller ```app/controllers/photos_controller.rb```:

    class PhotosController < ApplicationController
      def index
        @photos = Photo.page(1)
      end

      def page
        @photos = Photo.page(params[:page])
        render layout: false
      end
    end

Routes ```config/routes.rb```:

    get 'photos'       => 'photos#index'
    get 'photos/:page' => 'photos#page'


## Messages


### Tools to be considered

* Figure out if we can build apps easier on a top of http://harpjs.com
* See if we can make use of this: https://github.com/elclanrs/jq-idealforms
* Nice autocompletion tool: http://ichord.github.io/At.js/
* For touch devices (no need for jQuery UI): http://pornel.net/slip/ http://pornel.net/slip/
* Scrolling on iPad: http://iscrolljs.com/
* Add to blog: https://github.com/jansepar/picturefill
* For user input: https://github.com/loadfive/knwl.js
* Touch guestures: http://eightmedia.github.io/hammer.js/
* Spinner: http://viduthalai1947.github.io/loaderskit/
* Maybe we can include spinner in autoform generator: http://xixilive.github.io/jquery-spinner
* Blog post layout templates: http://adobe-webplatform.github.io/css-regions-polyfill/
* Might be used for subscription thing: http://andyatkinson.com/projects/promoSlide
* Email template: https://github.com/leemunroe/html-email-template
* Dropdown and select box: http://github.hubspot.com/tether/docs/welcome/