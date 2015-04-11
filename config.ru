require ::File.join( ::File.dirname(__FILE__), 'app' )

app = MyApp.new
fix_script_name = lambda do |env|
  env["SCRIPT_NAME"] = env["HTTP_X_SCRIPT_NAME"]
  app.call(env)
end

run fix_script_name
#run MyApp.new