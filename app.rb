require 'debug'
require "awesome_print"
require 'bcrypt'
require 'securerandom'

require_relative 'models/category'
require_relative 'models/blogg'
require_relative 'models/user'
require_relative 'models/base'

class App < Sinatra::Base

    setup_development_features(self)

    # Funktion för att prata med databasen
    # Exempel på användning: db.execute('SELECT * FROM bloggs')
    def db
      return @db if @db
      @db = SQLite3::Database.new(DB_PATH)
      @db.results_as_hash = true

      return @db
    end

    configure do
      enable :sessions
      set :session_secret, SecureRandom.hex(64)
    end
  
    before do
      if session[:user_id]
        @current_user = User.find(session[:user_id])
      end
    end

    post '/login' do
      user = User.find_by_username(params["username"])
    
      unless user
        redirect ('/login')
      end
    
      bcrypt = BCrypt::Password.new(user["password"])
    
      if bcrypt == params["password"]
        session[:user_id] = user["id"]
        redirect '/admin'
      else
        redirect ('/login')
      end
    end

    get '/login' do
      erb :login
    end

    get '/admin' do
      redirect '/login' unless @current_user
      erb :'admin/index'
    end

    post '/logout' do
      session.clear
      redirect '/bloggs'
    end

    # Routen /
    get '/' do
      redirect('/bloggs')
    end

    #Routen hämtar alla bloggs i databasen
    get '/bloggs' do
      @bloggs = Blogg.all
      @categories = Category.all
      p @bloggs
      p @categories
      erb(:"bloggs/index")
    end

    get '/categories' do
      @categories = Category.all
      erb :'categories/index'
    end

    # Routen visar ett formulär för att spara en ny inlägg till databasen.
    get '/bloggs/new' do
      redirect '/login' unless session[:user_id]
      @categories = Category.all
      erb(:"bloggs/new")
    end

    # Routen sparar en blogg till databasen och gör en redirect till '/bloggs'.
    post '/bloggs' do
      p params
      rubrik = params["heading"]
      beskrivning = params["description"]
      tema = params["category_id"]
      Blogg.create(rubrik, beskrivning, tema)
      redirect("/bloggs")
    end

    post '/categories' do
      p params
      tema_title = params["category_title"]
      Category.create(tema_title)
      redirect("/categories")
    end

    # Routen visar all info (från databasen) om en blogg
    get '/bloggs/:id' do | id |
      @blogg = Blogg.find(id)
      p @blogg
      erb(:"bloggs/show")
    end
   
    # Routen tar bort bloggen med id
    post '/bloggs/:id/delete' do | id |
      Blogg.delete(id)
      redirect("/bloggs")
    end

    post '/categories/:id/delete' do |id|
      tema_title = params["category_title"]
      Category.destroy(id)
      redirect("/categories")
    end
    
    # Routen visar ett formulär på edit.erb för att ändra bloggen med id
    get '/bloggs/:id/edit' do | id |
      @blogg = Blogg.find(id)
      @categories = Category.all
      erb(:"bloggs/edit")
    end

    get '/categories/:id/edit' do |id|
      @category = Category.find(id)
      @bloggs = Blogg.all_by_category_id(id)
      erb :'categories/edit'
    end

    # Routen sparar ändringarna från formuläret
    post "/bloggs/:id/update" do | id |
      u_rubrik = params["heading"]
      u_beskrivning = params["description"]
      u_tema = params["category_id"]
      Blogg.update(id, u_rubrik, u_beskrivning, u_tema)
      redirect("/bloggs")
    end

    post '/categories/:id/update' do |id|
      tema_title = params["category_title"]
      Category.update(tema_title)
      redirect("/categories")
    end



    

end
