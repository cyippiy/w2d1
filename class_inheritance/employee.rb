class Employee
  
  attr_accessor :boss
  attr_reader :name, :salary
  
  def initialize(name,title,salary,boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end
  
  def bonus(multi)
    @salary * multi
  end
  
end

class Manager < Employee
  attr_accessor :employees
  
  
  def initialize(employees,name,title,salary,boss)
    @employees = employees
    super(name,title,salary,boss)
  end
  
  def bonus(multi)
    counter = 0
    @employees.each do |employee|
      # if employee.is_a?(Manager)
      #     counter+=employee.bonus(multi)
      #     counter+=super(multi)
      # else
        counter += employee.salary
        if employee.is_a?(Manager)
          counter += employee.bonus(1)
        end
    end
    return counter*multi
  end
  
end

if __FILE__ == $PROGRAM_NAME
  ned = Manager.new([],"ned","founder", 1000000,nil)
  darren = Manager.new([],"darren","TA Manager",78000,ned)
  shawna = Employee.new("shawna","TA",12000 ,darren)
  david = Employee.new("david","TA",10000,darren)

  ned.employees << darren
  darren.employees << shawna 
  darren.employees << david
  
  p ned.bonus(5) # => 500_000
  p darren.bonus(4) # => 88_000
  p david.bonus(3) # => 30_000
end