
Host.destroy_all
host1 = Host.create(username: "Host1")
host2 = Host.create(username: "Host2")
host3 = Host.create(username: "Host3")
host4 = Host.create(username: "Host4")
host5 = Host.create(username: "Host5")
host6 = Host.create(username: "Host6")

Party.destroy_all
party1 = Party.create(name: "PARTY1", time_and_date: "Sept 23, 2019", location: "Club", admission: 25, entertainment: "DJ", theme: "themeeee", dress_code: "nice", host_id: 1)
party2 = Party.create(name: "PARTY2", time_and_date: "Jun 06, 2009", location: "House", admission: 15, entertainment: "Laptop", theme: "House-warming", dress_code: "Regular", host_id: 2)
party3 = Party.create(name: "PARTY3", time_and_date: "Aug 31, 2019", location: "Room", admission: 0, entertainment: "Ipod", theme: "Chill", dress_code: "sweats", host_id: 2)
party4 = Party.create(name: "PARTY4", time_and_date: "Jan 20, 2019", location: "Jail", admission: 100, entertainment: "Hmm", theme: "Prison", dress_code: "Orange Jumpsuits", host_id: 2)
party5 = Party.create(name: "PARTY5", time_and_date: "Dec 25, 2019", location: "Walmart", admission: 10, entertainment: "Band", theme: "Nametags", dress_code: "Blue vests", host_id: 5)
party6 = Party.create(name: "PARTY6", time_and_date: "April 05, 2019", location: "Hef's House", admission: 75, entertainment: "...;)", theme: "You knowwww", dress_code: "nothing at all", host_id: 6)

Guest.destroy_all
guest1 = Guest.create(username: "Guest1")
guest2 = Guest.create(username: "Guest2")
guest3 = Guest.create(username: "Guest3")
guest4 = Guest.create(username: "Guest4")
guest5 = Guest.create(username: "Guest5")
guest6 = Guest.create(username: "Guest6")

Attendance.destroy_all
attendance1 = Attendance.create(party_id: "1", guest_id: "1")
attendance2 = Attendance.create(party_id: "1", guest_id: "2")
attendance3 = Attendance.create(party_id: "1", guest_id: "3")
attendance4 = Attendance.create(party_id: "4", guest_id: "4")
attendance5 = Attendance.create(party_id: "5", guest_id: "4")
attendance6 = Attendance.create(party_id: "6", guest_id: "4")

