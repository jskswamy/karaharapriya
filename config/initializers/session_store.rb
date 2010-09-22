# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_karaharapriya_session',
  :secret      => '978ae8c5dd816ff1c1f0eec21090d656a80b884e81f191621c43d490b2f8dbdc6ea89165313b1355a949917323a04a5cd912d70446a032b42588998c3c235abe'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
