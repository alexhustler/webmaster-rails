Webmaster::Rails
================

Tools for building websites on top of Rails + MongoDB + Character


## Redactor (Slate license for $99)

In characters ```admin.coffee```:

    #= require redactor

In characters ```admin.scss```:

    @import "admin/redactor";


## Nivo Slider

In ```applictaion.coffee```:

    #= require jquery.nivo.slider

In ```application.scss```:

    //= require nivo-slider
    //= require nivo-default


## Mongo Backup

Backup database and upload it to S3 from Cloud66. Restore tool is included as well.

Do backup:

    rake mongo:backup

List available backups:

    rake mongo:list_backups

Restore from FILE:

    rake mongo:restore FILE=<filename.tag.gz>


## Photos

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