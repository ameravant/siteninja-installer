# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_siteninja-setup_session',
  :secret      => '5fad5e4949a6fc860fd6070bebabaabda6a1a48b6bdcf6dacb5c6658686316fc0860f73c002bf2aad47f7b8f47add93969f4bdfa9a1d34636b3e076ea426006a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
