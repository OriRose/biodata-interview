require_relative 'XOR' #This script contains utility functions for XORing binairy and hexadecimal strings and also converting from hexadecimal to binary and vice versa.
require 'securerandom'

def right_shift_hex(hex, offset)
#This method converts a given hexadecimal string to a binary string, removes a number of bits from the right equal to a
#given offset integer(in the rest of the code this number is always 1), adds the same amount of 0s to the left,
#and return the result after converting the binary string back to hexadecimal.
  binary = hex_to_bin(hex)
  shifted_binary  = '0' * offset + binary[0...-1 * offset]

  bin_to_hex(shifted_binary)
end

def lfsr_step_hex(current_hex, feedback_hex)
#This method applies the above right_shift_hex method to a hexadecimal string with an offset of 1.
#If the last bit (after conversion to binary) is 1, it is also XOR'd with the given feedback hex.
  current_binary = hex_to_bin(current_hex)

  if current_binary[-1] == '0'
    right_shift_hex(current_hex, 1)
  else
    hex_xor(right_shift_hex(current_hex, 1), feedback_hex)
  end
end

def next_lfsr_hex_key(current_hex)
#This method returns the last two digits of a given hexadecimal string.
  current_hex[-2..-1]
end

def hex_to_char(hex)
#This method returns a short string based on a hexadecimal digit's value (after first converting it to integer)
#according to encoding. https://www.rubydoc.info/stdlib/core/Integer:chr
  hex.to_i(16).chr
end

def byte_to_hex(byte)
#This method returns the hexadecimal representation of a byte value (in this code this is used for string characters).
  hex = byte.unpack('C2').first.to_s(16).upcase
  hex.length == 1 ? '0' + hex : hex #This is done to make sure the result is always of length 2, to properly XOR it with the 2-length key segment later.
end

def crypt(data, initial_value)
#This method encrypts the data string using the given initial value. The initial value can be any hexadecimal number.
#For generating random hex numbers, you can use this generator: https://www.browserling.com/tools/random-hex.
#Alternatively, you can use the method SecureRandom.hex.
  feedback_hex = '87654321' #This is effectively the cipher's "salt".
  initial_value = initial_value.to_s(16).upcase
  output_string = ''

  data.each_char do |char|
    8.times do
      initial_value = lfsr_step_hex(initial_value, feedback_hex)
    end

    char_hex = byte_to_hex(char)
    key = next_lfsr_hex_key(initial_value)

    output_string += hex_to_char(hex_xor(char_hex, key))
  end
  #The initial value is "scarmbled" 8 times per character of the data string using the lfsr_step_hex method and it's last two digits are XOR'd with
  #The current character's hexadecimal value, before being converted back to a string character and added to the output string.
  #(8 is an arbitrary number of sufficient size).
  output_string
end

#Important notes and known issues:

#*The crypt method works for both encryption and decryption, given the same initial value. Example:
# crypt(crypt("There was probably a simpler solution but I couldn't find it",0x863b3ebe66dc000dba5e8da4a313b2d2),0x863b3ebe66dc000dba5e8da4a313b2d2)
# => "There was probably a simpler solution but I couldn't find it"

#*Because of the way lfsr_step_hex works, using an initial value hex that starts with a lot 0s (after conversion to binary) causes the encryption to be ineffective. Example:
# crypt('I like big hexes and I can not lie',0x10000000000000000000000000000000000000000000000000000000000000000000000000)
# => "I like big hexes and I can not lie"

#*Initial values that are 'close' produces the same results. Therefore this cipher might be brute forced and is not truly secure. Example:
# crypt('Very secret message',0xda250bcf43be039dbc7bf6203a3c4475)
# => "\xA9\x9A\x8D\x86\xDF\x8C\x9A\x9C\x8D\x9A\x8B\xDF\x92\x9A\x8C\x8C\x9E\x98\x9A"
# crypt('Very secret message',0xda250bcf43be039dbc7bf6203a3c4775)
# => "\xA9\x9A\x8D\x86\xDF\x8C\x9A\x9C\x8D\x9A\x8B\xDF\x92\x9A\x8C\x8C\x9E\x98\x9A"

#**Pick a reasonable initial value hex if you choose one manually**