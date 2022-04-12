require_relative 'LFSR'

p "code:"
p code = rand(10000...100000000)
p "encrypted string:"
p crypt(ARGV[0],code)

p crypt(crypt(ARGV[0],code),code)