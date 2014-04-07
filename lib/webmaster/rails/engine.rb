module Webmaster
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace Webmaster::Rails
      initializer "webmaster-rails.assets.precompile" do |app|
# NOTE: this might be handy
#        app.config.assets.precompile += %w( vendor/modernizr.js )
      end
      rake_tasks do
        load "tasks/mongo/backup.rake"
      end
    end
  end
end