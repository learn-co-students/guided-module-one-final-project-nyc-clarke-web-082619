
class Host < ActiveRecord::Base
    has_many :parties

    def host_main_menu
        prompt = TTY::Prompt.new
        hosters_main_menu = prompt.select("What can I help you with?") do |hoster|
            hoster.choice "Create A New Party", -> { host_create_new_party }
            hoster.choice "See My Parties", -> { find_my_parties }
            hoster.choice "See All Parties ", -> { view_all_parties }
            hoster.choice "Cancel A Party", -> { cancel_parties }
            hoster.choice "Logout", -> { host_or_guest }
        end
    end
    
    def host_create_new_party
        prompt = TTY::Prompt.new
        create_party = prompt.collect do
            key(:name).ask('What would you like to call your party?:')
            key(:time_and_date).ask('Time and Date:')
            key(:location).ask('Location of Venue:')
            key(:admission).ask('Admission in $:')
            key(:entertainment).ask('What is your partys entertainment?:')
            key(:theme).ask('Party Theme:')
            key(:dress_code).ask('Dress Code:')
        end
        new_party = Party.create(create_party)
        #party = Party.find_by(name: "#{new_party}")
        # party.host = self
        self.parties << new_party
        puts "Congrats, you have successfully created a new party!"
        sleep(2)
        host_main_menu
    end

    def cancel_parties
        if self.parties.length == 0
            puts "You have no upcoming parties."
            sleep(2)
            puts "There is nothing to cancel."
            sleep(2)
            puts "You can either Create A New Party or stay boring."
            sleep(3)
            host_main_menu
        else

            parties = self.parties.map {|party| party.name}
            prompt = TTY::Prompt.new
            party_name = prompt.select("Which party would you like to cancel?", parties)

            party = Party.find_by(name: "#{party_name}")
            party_options = prompt.select("Are you sure you would like to cancel this party?") do |parties|
                parties.choice "Yes", -> { self.parties.delete(party) 
                party.destroy }
                parties.choice "No", -> { cancel_parties }
                parties.choice "Main Menu", -> { host_main_menu }
            end
        end
        host_main_menu
    end

    def find_my_parties
        if self.parties.length == 0
            puts "You have no upcoming parties."
            sleep(2)
            puts "Why don't we start planning one?"
            sleep(2)
            puts "Select the 'Create A New Party' option to get started."
            sleep(3)
            host_main_menu
        else

            parties = self.parties.map {|party| party.name}
            prompt = TTY::Prompt.new
            party_name = prompt.select("These are your parties", parties)
        
            party = Party.find_by(name: "#{party_name}")
            party = Party.find_by(id: party.id)
            party_options = prompt.select("What would you like to do?") do |parties|
                parties.choice "View", -> { puts "Name:               " + party.name + "\n\n"
            puts "Time and Date:      " + party.time_and_date + "\n\n"
            puts "Location:           " + party.location + "\n\n"
            puts "Admission Price:    " + party.admission.to_s + "\n\n"
            puts "Entertainment:      " + party.entertainment + "\n\n"
            puts "Theme:              " + party.theme + "\n\n"
            puts "Dress Code:         " + party.dress_code + "\n\n"
            puts "Host:               " +party.host.username + "\n\n"
            sleep(2) 
            find_my_parties}
            parties.choice "View All Guests", -> { puts party.attendances.map{|attendance| attendance.guest.username}
            sleep(2)
            find_my_parties}
                parties.choice "Edit", -> { edit_my_party(party)}
                parties.choice "Main Menu", -> { host_main_menu }
            end
        end
    end


    def view_all_parties
        all_parties = Party.all.map {|party_name| party_name.name}
        prompt = TTY::Prompt.new
        parties_names = prompt.select("These are all of the upcoming parties", all_parties)
        
        party = Party.find_by(name: "#{parties_names}")
        party_options = prompt.select("What would you like to do?") do |parties|
            parties.choice "View", -> { puts "Name:                " + party.name + "\n\n"
        puts "Time and Date:       " + party.time_and_date + "\n\n"
        puts "Location:            " + party.location + "\n\n"
        puts "Admission Price:     " + party.admission.to_s + "\n\n"
        puts "Entertainment:       " + party.entertainment + "\n\n"
        puts "Theme:               " + party.theme + "\n\n"
        puts "Dress Code:          " + party.dress_code + "\n\n"
        puts "Host:                " +party.host.username + "\n\n"
        sleep(2) }
            parties.choice "Main Menu", -> { host_main_menu }
        end
        host_main_menu
    end

    def edit_my_party(party)
        prompt = TTY::Prompt.new
        
        prompt.select("What would you like to edit?") do |party_edit|
        #     party_edit.choice "Name", -> { answer_name = prompt.ask("What would you like the new name to be?")
        # party.update(name: answer_name) 
        # self.parties.find_by(name: answer_name).save}
            party_edit.choice "Time and Date", -> {answer_timedate = prompt.ask("What would you like the new time and date to be?")
            party.update(time_and_date: answer_timedate) 
            edit_my_party(party) }
            party_edit.choice "Location", -> {answer_location = prompt.ask("What would you like the new location to be?")
            party.update(location: answer_location) 
            edit_my_party(party) }
            party_edit.choice "Admission Price", -> {answer_price = prompt.ask("What would you like the new price to be?")
            party.update(admission: answer_price) 
            edit_my_party(party) }
            party_edit.choice "Entertainment", -> {answer_entertainment = prompt.ask("What would you like the new entertainment to be?")
            party.update(entertainment: answer_entertainment) 
            edit_my_party(party) }
            party_edit.choice "Theme", -> {answer_theme = prompt.ask("What would you like the new theme to be?")
            party.update(theme: answer_theme) 
            edit_my_party(party) }
            party_edit.choice "Dress Code", -> {answer_dresscode = prompt.ask("What would you like the new dress code to be?")
            party.update(dress_code: answer_dresscode) 
            edit_my_party(party) }
            party_edit.choice "Main Menu", -> { host_main_menu }
        end
       
    end

    def view_guests
        self.parties.select {|attendance| attendance.guest}
    end

end
