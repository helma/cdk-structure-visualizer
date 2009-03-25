# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cdk-structure-visualizer_session',
  :secret      => '5dbd47d00df02088efe4e1035a7df5080e63a0109e4dc95289f9ccb2082ce7a23de5bb6c0682f4fd9be1f1f3918aa51d35a32706aa0b0b60638efc75fce97caf'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
