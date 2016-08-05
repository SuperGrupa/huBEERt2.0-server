require 'bcrypt'

class Seed
  def run
    cities
    beers
    pubs
    users

    comments
    events
    offers

    subscriptions
    notifications
  end

  private

    def cities
      ['Poznań', 'Warszawa', 'Wrocław'].each do |city|
        City.create!(name: city)
      end
    end

    def beers
      20.times do
        Beer.create!(
          name: Faker::Beer.name.slice(0, 30),
          description: Faker::Lorem.paragraph(3).slice(0, 300),
          alcohol: '%.1f' % Random.rand(10.0),
          extract: '%.1f' % (Random.rand(25.0) + 0.1),
          volume:  (Random.rand(4) + 3)/10.0
        )
      end
    end

    def pubs
      fictional_names = [
        "The Admiral's Arms", "The Alibi Room", "The Angler's Rest", "The Albert", "The Archer", "Archie Bunker's Place",
        "The Bloated Float Inn", "The Broken Drum", "The Clansman", "Double Deuce", "The Elephant", "The Flowing Bowl",
        "Grilby's", "Harry Hope's Saloon", "The Iron Horse", "John McRory's Place", "The King and Queen Tavern",
        "Levy's", "The Lizard's Head", "The Midnight Star", "Night Shot", "The Old Pink Dog", "Los Pollos Hermanos",
        "Barley Mow", "Barrels", "Brewery Tap", "Hop Pole", "Sir John Barleycorn", "Three Tuns",
        "Blue Door", "Olde Cheshire Cheese", "Haunch of Venison", "Shoulder of Mutton", "Oxnoble",
        "Bierkeller", "Rai d'Or"
      ]

      City.all.each_with_index do |city, i|
        12.times do |j|
          name = fictional_names[i*12 + j]
          Pub.create!(
            name: name,
            description: Faker::Lorem.paragraph.slice(0, 300),
            phone: Random.rand(899999999) + 100000000,
            email: Faker::Internet.email(name),
            hidden: Faker::Boolean.boolean(0.2),
            address: Faker::Address.street_address,
            city_id: city.id
          )
        end
      end
    end

    def users
      logins_taken = Set.new

      20.times do
        login = choose_login(logins_taken)
        logins_taken << login
        User.create!(
          login: login,
          email: Faker::Internet.email(login),
          password_digest: BCrypt::Password.create('qwertyuiop')
        )
      end
    end

    def comments
      users_num = User.all.length

      Pub.all.each do |pub|
        Random.rand(10).times do
          Comment.create!(
            text: Faker::Lorem.sentence.slice(0, 160),
            rating: Random.rand(4) + 2,
            pub_id: pub.id,
            user_id: Random.rand(users_num - 1) + 1,
            created_at: Faker::Date.between(1.year.ago, Date.today)
          )
        end
      end
    end

    def events
      Pub.all.each do |pub|
        Random.rand(10).times do
          Event.create!(
            name: Faker::Lorem.sentence(3, false, 2).slice(0, 50),
            date: Faker::Time.between(1.hour.from_now, 1.month.from_now).change(min: 0),
            description: Faker::Lorem.paragraph.slice(0, 300),
            pub_id: pub.id
          )
        end
      end
    end

    def offers
      Pub.all.each do |pub|
        Beer.all.sample(Random.rand(17) + 3).each do |beer|
          Offer.create!(
            value: '%.2f' % (Random.rand(15.0) + 3.0),
            pub_id: pub.id,
            beer_id: beer.id
          )
        end
      end
    end

    def subscriptions
      User.all.each do |user|
        Pub.all.sample(Random.rand(4) + 1).each do |pub|
          Subscription.create!(
            user_id: user.id,
            pub_id: pub.id
          )
        end
      end
    end

    def notifications
      Event.all.each do |event|
        notification = Notification.create!(
          message: Faker::Lorem.sentence.slice(0, 160),
          event_id: event.id
        )

        notification.event.pub.subscriptions.each do |s|
          User.find(s.user_id).notifications << notification
        end
      end
    end

    def choose_login(logins_taken)
      login = ""
      loop do
        login = Faker::Name.last_name.downcase.slice(0, 20)
        break unless logins_taken.include? login
      end
      login
    end
end

s = Seed.new
s.run
