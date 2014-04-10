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