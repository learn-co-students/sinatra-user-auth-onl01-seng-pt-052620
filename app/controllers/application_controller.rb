class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

#   #this lab is broken and I keed getting this error:  jreyes@MSI:/mnt/c/users/senti/dev/flatiron/labs/sinatra-user-auth-onl01-seng-pt-052620$ Traceback (most recent call last):
#         3: from /home/jreyes/.rvm/gems/ruby-2.6.1/bin/ruby_executable_hooks:24:in `<main>'
#         2: from /home/jreyes/.rvm/gems/ruby-2.6.1/bin/ruby_executable_hooks:24:in `eval'
#         1: from /home/jreyes/.rvm/gems/ruby-2.6.1/bin/learn-test-wip:23:in `<main>'
# /home/jreyes/.rvm/gems/ruby-2.6.1/bin/learn-test-wip:23:in `load': /home/jreyes/.rvm/gems/ruby-2.6.1/gems/learn-test-3.2.0/bin/learn-test-wip:44: syntax error, unexpected '.' (SyntaxError)
# . "$(git --exec-path)/git-sh-s...
# ^
# /home/jreyes/.rvm/gems/ruby-2.6.1/gems/learn-test-3.2.0/bin/learn-test-wip:49: syntax error, unexpected tINTEGER, expecting end-of-input
# trap 'rm -f "$TMP-*"' 0

  

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :home
  end

  get '/registrations/signup' do

    erb :'/registrations/signup'
  end

  post '/registrations' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:user_id] = @user.id

    redirect '/users/home'
  end

  get '/sessions/login' do

    # the line of code below render the view page in app/views/sessions/login.erb
    erb :'sessions/login'
  end

  post '/sessions' do
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/users/home'
    end
    redirect '/sessions/login'
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  get '/users/home' do

    @user = User.find(session[:user_id])
    erb :'/users/home'
  end
end
