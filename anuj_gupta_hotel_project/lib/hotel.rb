require_relative "room"

class Hotel

    attr_reader :rooms

    def initialize(name, hash)
        @name = name 
        @rooms = {}
        hash.each do |k, v|
            @rooms[k] = Room.new(v)
        end
    end

    def name
        new_arr = []
        arr = @name.split(" ")
        arr.each do |word|
            new_arr << word.capitalize
        end
        new_arr.join(" ")
    end


    def room_exists?(room_name)
        @rooms.each do |k,v|
            if room_name == k 
                return true
            end
        end
        false
    end


    def check_in(person, room_name)
        if !self.room_exists?(room_name)
            p "sorry, room does not exist"
        else
            room = @rooms[room_name]
            if room.add_occupant(person)
                print "check in successful"
            else
                print "sorry, room is full"
            end
        end
    end

    def has_vacancy?
        @rooms.each do |k, v|
            if v.available_space > 0
                return true 
            end
        end
        false
    end

    def list_rooms
        @rooms.each do |k, v|
            print "#{k}.*#{v.available_space}\n"
        end
    end

end
