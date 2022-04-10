class MyFirstClass
    def print(str)
        p str
    end
end

object = MyFirstClass.new
object.print(ARGV[0])

# if no input argument is given, returns nil