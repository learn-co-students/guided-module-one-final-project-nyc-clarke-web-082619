class Guest < ActiveRecord::Base
    has_many :attendances
    has_many :parties, through: :attendances

    def partier_main_menu
        prompt = TTY::Prompt.new
        partiers_main_menu = prompt.select("What can I help you with?") do |partier|
            partier.choice "See All Parties", -> { see_all_parties }
            partier.choice "See All My Parties", -> { find_my_parties }
            partier.choice "Logout", -> { host_or_guest }
        end
    end

    def see_all_parties
        all_parties = Party.all.map {|party_name| party_name.name}
        prompt = TTY::Prompt.new
        parties_names = prompt.select("These are all of the upcoming parties", all_parties )
        
        party = Party.find_by(name: "#{parties_names}")
        party_options = prompt.select("What would you like to do?") do |parties|
            parties.choice "View", -> { puts "Name: " + party.name + "\n\n"
        puts "Time and Date: " + party.time_and_date + "\n\n"
        puts "Location: " + party.location + "\n\n"
        puts "Admission Price: " + party.admission.to_s + "\n\n"
        puts "Entertainment: " + party.entertainment + "\n\n"
        puts "Theme: " + party.theme + "\n\n"
        puts "Dress Code: " + party.dress_code + "\n\n"
        puts "Host: " + party.host.username + "\n\n"
        sleep(2) }
            parties.choice "Attend This Party", -> { self.parties << party}
            parties.choice "Main Menu", -> { partier_main_menu }
        end
        partier_main_menu
    end

    def find_my_parties
        if self.parties.length == 0
            puts "You have no upcoming parties."
            sleep(1)
            puts "Looks like you're staying home tonight!"
            sleep(2)
            partier_main_menu
        else

        parties = self.parties.map {|party| party.name}
        prompt = TTY::Prompt.new
        party_name = prompt.select("These are your parties", parties)
        
        party = Party.find_by(name: "#{party_name}")
        party = Party.find_by(id: party.id)
        party_options = prompt.select("What would you like to do?") do |parties|
            parties.choice "View", -> { puts "Name: " + party.name + "\n\n"
        puts "Time and Date: " + party.time_and_date + "\n\n"
        puts "Location: " + party.location + "\n\n"
        puts "Admission Price: " + party.admission.to_s + "\n\n"
        puts "Entertainment: " + party.entertainment + "\n\n"
        puts "Theme: " + party.theme + "\n\n"
        puts "Dress Code: " + party.dress_code + "\n\n"
        puts "Host: " + party.host.username + "\n\n"
        sleep(2) 
        find_my_parties}
            parties.choice "Unattend Party", -> {self.parties.delete(party)
        Attendance.delete(Attendance.find_by(party_id: party.id))
        partier_main_menu }
            parties.choice "Main Menu", -> { partier_main_menu }
        end
    end
    end

end