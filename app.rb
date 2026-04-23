require 'debug'
require "awesome_print"

require_relative 'models/blogg'
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

    # Routen /
    get '/' do
      redirect('/bloggs')
        erb :index
    end

    #Routen hämtar alla bloggs i databasen
    get '/bloggs' do
      @bloggs = Blogg.all
      p @bloggs
      erb(:"bloggs/index")
    end

    # Routen visar ett formulär för att spara en ny inlägg till databasen.
    get '/bloggs/new' do
      erb(:"bloggs/new")
    end

    # Routen sparar en blogg till databasen och gör en redirect till '/bloggs'.
    post '/bloggs' do
      p params
      rubrik = params["heading"]
      beskrivning = params["description"]
      tema = params["category_id"]
      Blogg.create(rubrik, beskrivning)
      redirect("/bloggs")
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
    
    # Routen visar ett formulär på edit.erb för att ändra bloggen med id
    get '/bloggs/:id/edit' do | id |
      @blogg = Blogg.find(id)
      erb(:"bloggs/edit")
    end

    # Routen sparar ändringarna från formuläret
    post "/bloggs/:id/update" do | id |
      u_rubrik = params["heading"]
      u_beskrivning = params["description"]
      u_tema = params["category_id"]
      Blogg.update(id, u_rubrik, u_beskrivning)
      redirect("/bloggs")
    end

    

end
