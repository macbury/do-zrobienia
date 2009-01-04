require 'xmpp4r/xmpp4r'
require 'xmpp4r-simple'

konfig = YAML::load_file("#{RAILS_ROOT}/config/jabber.yml")

Jabber::debug = !(RAILS_ENV == 'production')

JABBER_CLIENT = Jabber::Simple.new( konfig['jid'], konfig['haslo'] ) unless konfig['jid'].nil?