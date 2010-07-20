# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_address_book_session',
  :secret      => '7af63f53e2de17ef43acd2f8b139ecffa8688cc7fb573233d5f464614b22b8e7e61d0cd0243e2b2c23634ac6721345022afd5ae9222bc376b67c2c349108f749'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
