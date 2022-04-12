# Note: This script doesn't actually work properly. This is probably because of the way Ruby parses string in cmd.
# It seems like it's adding backslashes and changing the input string (see line 6). decryption seems to work fine withing the
# encryption script (see line 8 in encrypt.rb). TODO: Fix this.

require_relative 'LFSR'

p ARGV[0]
p "decrypted string:"
p crypt(ARGV[0],ARGV[1].to_i)