
require 'tty-prompt'
require "pry"

old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil
prompt = TTY::Prompt.new

def greet
    puts '*******   Welcome to "Party Connect!"   *******'
    sleep(2)
    puts "Whether you're hosting a party, or attending one"
    sleep(2)
    puts "        This app connects you together!"
    sleep(2)
end

def host_or_guest
    prompt = TTY::Prompt.new
    user_identity = prompt.select("Are you hosting an event or looking to party?") do |user|
        user.choice "Hosting!", -> { host_create_or_login } 
        user.choice "Partier!", -> { partier_create_or_login }
        user.choice "Exit App", -> {exit}
    end
end

def host_create_or_login
    prompt = TTY::Prompt.new
    create_or_login = prompt.select("Are you a new or returning Host?") do |host|
        host.choice "Login", -> { host_login } #line 22
        host.choice "Create an Account", -> { host_create_account } #line 31
    end
end

def host_login
    puts "Login with your Username and Password below to begin."
    prompt = TTY::Prompt.new
    hosts_login = prompt.collect do
        key(:username).ask("Username:")
    end
    if Host.find_by(username: "#{hosts_login[:username]}")
        host = Host.find_by(username: hosts_login[:username])
        host.host_main_menu
        # puts "Let's start the party!"
        # sleep(2)
        # host_main_menu
    else 
        puts "No username found!"
        host_login
    end
end

def host_create_account
    puts "Create a Username and Password below to begin."
    prompt = TTY::Prompt.new
    create_user = prompt.collect do
        key(:username).ask('Provide a desired Username:')
    end
    puts "Let's start the party!"
    sleep(2)
    Host.create(create_user)
end


def partier_create_or_login
    prompt = TTY::Prompt.new
    create_or_login = prompt.select("Are you a new or returning Partier?") do |partier|
        partier.choice "Login", -> { partier_login }
        partier.choice "Create an Account", -> { partier_create_account }
    end
end

def partier_login
    puts "Login with your Username and Password below to begin."
    prompt = TTY::Prompt.new
    partiers_login = prompt.collect do
        key(:username).ask("Username:")
    end
    if Guest.find_by(username: "#{partiers_login[:username]}")
        guest = Guest.find_by(username: partiers_login[:username])
        guest.partier_main_menu
    else 
        puts "No username found!"
        partier_login
    end
    # puts "Let's get ready to party!"
    # sleep(2)
    # partier_main_menu
end

def partier_create_account
    puts "Create a Username below to begin."
    prompt = TTY::Prompt.new
    create_partier = prompt.collect do
        key(:username).ask('Provide a desired Username:')
    end
    puts "Let's get ready to party!"
    sleep(2)
    Guest.create(create_partier)
end


# def host_main_menu
#     prompt = TTY::Prompt.new
#     hosters_main_menu = prompt.select("What can I help you with?") do |hoster|
#         hoster.choice "Create A New Party", -> { host_create_new_party }
#         hoster.choice "See My Parties", -> { host_find_my_parties }
#         hoster.choice "See All Parties ", -> { }
#         hoster.choice "", -> { }
#         hoster.choice "Logout", -> { host_or_guest }
#     end
# end

# def host_create_new_party
#     prompt = TTY::Prompt.new
#     create_party = prompt.collect do
#         key(:name).ask('What would you like to call your party?:')
#         key(:time_and_date).ask('Time and Date:')
#         key(:location).ask('Location of Venue:')
#         key(:admission).ask('Admission in $:')
#         key(:entertainment).ask('Will your party have entertainment?:')
#         key(:theme).ask('Party Theme:')
#         key(:dress_code).ask('Dress Code:')
#     end
#     Party.create(create_party)
#     puts "Congrats, you have successfully created a new party!"
#     sleep(2)
#     host_main_menu
# end

# def host_find_my_parties

# end


# def partier_see_all_parties

# end




# puts "are you ready to party?!"
# sleep(1)
# prompt.keypress(".....press any key to continue", timeout: 5)

# host_or_guest = prompt.select("First, are you hosting an event or attending one?", %w(Host Guest))
#     if host_or_guest == "Host"
#         login_or_create = prompt.select("Please login, or create and account to start", %w(Login Create))
#         if login_or_create == "Create"
#             new_user = prompt.collect do
#                 key(:username).ask('Provide a desired Username:')
#                 key(:password).mask('Provide a password:')
#             end
#             host_new = Host.create(new_user)
#         elsif
#             login_or_create == "Login"
#             prompt.collect do
#                 key(:username).ask('Provide a desired Username:')
#                 key(:password).mask('Provide a password:')
#                 # Host.find_by(username: = ?, password = ?)
#             end
#         end
#     else puts "You ROCK"
#         sleep(2)
#         puts "end"
#     end
