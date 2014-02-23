class AppDelegate < PM::Delegate
  def on_load(app, options)
    open WelcomeScreen.new(nav_var: false)
  end
end