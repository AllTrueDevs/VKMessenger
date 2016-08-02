Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)

Rails.application.config.assets.precompile += %w(
  users.coffee
  music.coffee
  messages.coffee
)