require 'debug'
require "awesome_print"

class App < Sinatra::Base

    setup_development_features(self)

    # Funktion för att prata med databasen
    # Exempel på användning: db.execute('SELECT * FROM fruits')
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
      @bloggs = db.execute('SELECT * FROM bloggs')
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
      db.execute("INSERT INTO bloggs (heading, description) VALUES (?,?)", [rubrik, beskrivning])
      redirect("bloggs")
    end

    

end
