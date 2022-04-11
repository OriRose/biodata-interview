require 'bundler'
Bundler.require(:default)

cipher = Gibberish::AES.new('p4ssw0rd')
p cipher.encrypt(ARGV[0])