require 'el_finder/action'

class ElfinderController < ApplicationController
  load_and_authorize_resource :class => false
  #skip_authorization_check

  def frontend_wrapper
    # Prevent miniprofiler from appending javascript to json output
    Rack::MiniProfiler.discard_results
    Rack::MiniProfiler.deauthorize_request
    render :layout => 'elfinder_wrapper'
  end

  def frontend
    # Prevent miniprofiler from appending javascript to json output
    Rack::MiniProfiler.discard_results
    Rack::MiniProfiler.deauthorize_request
    render :layout => 'elfinder'
  end

  include ElFinder::Action

  el_finder(:backend) do

    # Prevent miniprofiler from appending javascript to json output
    Rack::MiniProfiler.discard_results
    Rack::MiniProfiler.deauthorize_request
    {
      :root => File.join(Rails.public_path, 'files'),#+params[:path],
      :url => '/files', #+params[:path],
      :defaultView => 'list', # icons or list
      :perms => {
        # http://rubular.com For regular expression testing
        # 
        # /Leichtathletik -> false
        # /Leichtathletik/test.jpg -> false
        # /Leichtathletik/Bilder -> false
        # /Leichtathletik/Bilder/test.jpg -> true

        /^[^\/]*$/ => {:read => true, :write => false, :rm => false}, # Absolutely don't know why this works
        /.*/ => {:read => true, :write => true, :rm => true}
        #/^[^\/]*(\/[^\/]+){0,0}$/ => {:read => true, :write => false, :rm => false},
        #/^[^\/]*\/{0,1}[^\/]*$/ => {:read => true, :write => false, :rm => false},
        #/^[^\/]*\/{0,3}$/ => {:read => true, :write => false, :rm => false},
        #/^[^\/]*\/{2,}[^\/]*$/ => {:read => true, :write => true, :rm => true}
        #/^[^\/]*\/{4,}[^\/]*$/ => {:read => true, :write => true, :rm => true}
        #'.' => {:read => true, :write => false, :rm => false} # '.' is the proper way to specify the home/root directory.
        # 'forbidden' => {:read => false, :write => false, :rm => false},
        # /README/ => {:write => false},
        # /pjkh\.png$/ => {:write => false, :rm => false},
        # /^(Welcome|README)$/ => {:read => true, :write => false, :rm => false},
        # '.' => {:read => true, :write => false, :rm => false}, # '.' is the proper way to specify the home/root directory.
        # /^test$/ => {:read => true, :write => true, :rm => false},
        # 'logo.png' => {:read => true},
        # /\.png$/ => {:read => false} # This will cause 'logo.png' to be unreadable.  
        #                              # Permissions err on the safe side. Once false, always false.
      },
      :extractors => { 
        'application/zip' => ['unzip', '-qq', '-o'], # Each argument will be shellescaped (also true for archivers)
        'application/x-gzip' => ['tar', '-xzf'],
      },
      :archivers => { 
        'application/zip' => ['.zip', 'zip', '-qr9'], # Note first argument is archive extension
        'application/x-gzip' => ['.tgz', 'tar', '-czf'],
      },
      :thumbs => true
    }
  end
end