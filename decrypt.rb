require 'bundler'
Bundler.require(:default)

cipher = Gibberish::AES.new('p4ssw0rd')
p cipher.decrypt(ARGV[0])