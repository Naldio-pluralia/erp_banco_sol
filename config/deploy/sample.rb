# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}
set :stage, :sample
set :rails_env, :production

# setup cloud
server '196.29.192.76', user: 'deploy', roles: %w{app db web}

set :deploy_to, '/home/deploy/nextbss'
# setup on-premisses
# server '10.5.1.178', user: 'administrador', roles: %w{app db web}

  # ssh_options: {
  #   keys: %w(/home/administrador/.ssh/id_rsa),
  #   forward_agent: true,
  #   auth_methods: %w(publickey)
  #   # password: "please use keys"
  # }



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com} 
