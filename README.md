# NOTICE:

This gem is not complete and should not be used in any Rails applications yet.

# MTGExtractor

MTGExtractor is a Ruby gem that can be used to create Magic: The Gathering based
applications. Because there is no public API for accessing MTG card data, we've
put togther a Ruby gem that allows you to build your own Magic: The Gathering
data source.

This gem can help you create an entire database of every MTG card, set, and so on.
It works by scraping the Gatherer web site (http://gatherer.wizards.com) for
card data.

Rails applications that use this gem will be able to:

  - Have their own database of MTG cards and MTG-related information
  - Have automatically generated ActiveRecord models available to their application
  that allow them access to the data
  - Have a simple way to update their database when new cards or sets release
  via rake tasks.

## Installation

Configure your Gemfile:

    gem 'mtgextractor'

Install the gem:

    bundle

Run the generator to generate the migrations and models:

    rails g mtgextractor

Run migrations to create the tables:

    rake db:migrate

## Updating your database

### Getting all cards and all sets

Populate your database with all cards for every set from Gatherer (this will take a while):

    RAILS_ENV=environment rake mtgextractor:update_all_sets

Optionally, you can begin processing all sets starting from a different position in the list.
The list of sets is dynamically acquired and sorted alphabetically. If you've already processed
all sets starting from Alara Reborn (the first in the list) to Apocalypse, you can start this
task over and begin the processing at the next set after Apocalypse (Arabian Nights). 

To do this, you can run this command:

    RAILS_ENV=environment START="Arabian Nights" rake mtgextractor:update_all_sets

Doing this will ignore processing all sets that come before Arabian Nights in the list.

### Processing one set at a time 

When a new set comes out, you can simply update your database for just that one
set. All you have to do is run a rake task and specify which set you want to
update.

    RAILS_ENV=environment SET="Set name" rake mtgextractor:update_set

Note: If you don't specify a RAILS_ENV, it will default to 'development'.

## Accessing your card data

After you run the generator and updated your database, you will have access to
the following ActiveRecord models in your Rails application:

  - **MtgCard**: Contains card attributes like name, mana cost, oracle text...
  - **MtgSet**: A set, such as "Innistrad".
  - **MtgType**: A card type, like "Land", "Instant", "Human", "Creature", etc...
  - **MtgCardType**: An associative entity for the many-to-many relationship between MtgCard and MtgType.

More documentation on this in progress...

## As a standalone gem

MTGExtractor does not have to be used in a Rails application solely, however most
of the work on this gem has been towards achieving that goal. If you wish to use
this gem as a standalone tool, you can simply make use of the classes that scrape
the Gatherer web site and return data.

Those classes are:

**MTGExtractor::SetExtractor**: Returns a list of URLs for each card in provided
set. These URLs point to each individual card's details page. Example:

    require 'mtgextractor'
    set_extractor = MTGExtractor::SetExtractor.new("Innistrad")
    all_cards_in_set = set_extractor.get_card_detail_urls

**MTGExtractor::CardExtractor**: Returns a hash of card data when given the
URL for a card details page. Example:

    require 'mtgextractor'
    black_lotus_url = 'http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=600'
    card_extractor = MTGExtractor::CardExtractor.new(black_lotus_url)
    black_lotus_data = card_extractor.get_card_details

## Support

### Ruby

MTGExtractor has been tested against the following Ruby versions:

  - 1.9.3

### Rails

MTGExtractor has been tested against the following Rails versions:

  - 3.2.6
