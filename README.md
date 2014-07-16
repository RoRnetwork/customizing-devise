![Devise Logo](https://raw.github.com/plataformatec/devise/master/devise.png)

## Getting started

```ruby
gem 'devise'
```

Run the bundle command to install it.

After you install Devise and add it to your Gemfile, you need to run the generator:

```console
rails generate devise:install
```

The generator will install an initializer which describes ALL Devise's configuration options and you MUST take a look at it. When you are done, you are ready to add Devise to any of your models using the generator:

```console
rails generate devise user
```

```console
rails generate devise:views users
```

Next, check the user for any additional configuration options you might want to add, such as confirmable or lockable. If you add an option, be sure to inspect the migration file (created by the generator if your ORM supports them) and uncomment the appropriate section.  For example, if you add the confirmable option in the model, you'll need to uncomment the Confirmable section in the migration. Then run `rake db:migrate`

Next, you need to set up the default URL options for the Devise mailer in each environment. Here is a possible configuration for `config/environments/development.rb`:

```ruby
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```

You should restart your application after changing Devise's configuration options. Otherwise you'll run into strange errors like users being unable to login and route helpers being undefined.

### Controller filters and helpers

Devise will create some helpers to use inside your controllers and views. To set up a controller with user authentication, just add this before_action (assuming your devise model is 'User'):

```ruby
before_action :authenticate_user!
```

If your devise model is something other than User, replace "_user" with "_yourmodel". The same logic applies to the instructions below.

To verify if a user is signed in, use the following helper:

```ruby
user_signed_in?
```

For the current signed-in user, this helper is available:

```ruby
current_user
```

You can access the session for this scope:

```ruby
user_session
```

After signing in a user, confirming the account or updating the password, Devise will look for a scoped root path to redirect. For instance, for a `:user` resource, the `user_root_path` will be used if it exists, otherwise the default `root_path` will be used. This means that you need to set the root inside your routes:

```ruby
root to: "welcome#index"
```

You can also override `after_sign_in_path_for` and `after_sign_out_path_for` to customize your redirect hooks.

in your `ApplicationController`:

```ruby
class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    protected
  def after_sign_in_path_for(resource)
    home_index_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

end
```

You can also override your `after_confirmation_path_for`,

create a new controller as `confirmations_controller.rb` into controller folder,


```ruby
class ConfirmationsController < Devise::ConfirmationsController
	protected
	 def after_confirmation_path_for(resource_name, resource)
      if signed_in?(resource_name)
        home_index_path
      else
        new_session_path(resource_name)
      end
    end
end

```