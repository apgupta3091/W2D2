require "employee"

class Startup

    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name 
        @funding = funding 
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        @salaries.each do |t, s|
            if title == t 
                return true 
            end
        end
        false
    end

    def >(other_startup)
        if self.funding > other_startup.funding
            return true
        else 
            return false
        end
    end

    def hire(name, title)
        if !valid_title?(title)
            raise "No title available"
        else
            emp = Employee.new(name, title)
            @employees << emp
        end 
    end

    def size 
        @employees.length
    end

    def pay_employee(emp)
        money = @salaries[emp.title]
        if @funding > money 
            @funding -= money 
            emp.pay(money)
        else
            raise "Not enough funding"
        end
    end

    def payday
        @employees.each do |emp|
            pay_employee(emp)
        end
    end

    def average_salary
        new_arr = []
        @employees.each do |emp|
            new_arr << @salaries[emp.title]
        end
        new_arr.sum / @employees.length
    end

    def close 
        @employees = []
        @funding = 0

    end

    def acquire(other_startup)
        @funding += other_startup.funding
        other_startup.salaries.each do |t, s|
            if !@salaries.has_key?(t)
                @salaries[t] = s
            end
        end
        other_startup.employees.each do |emp|
            @employees << emp 
        end
         
        other_startup.close 
    end

end
