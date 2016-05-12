# Offshore

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Bump to Phoenix 1.2-rc w/ Ecto 2.0.0-rc
  * https://gist.github.com/chrismccord/29100e16d3990469c47f851e3142f766
  ** "...translate_error function was found in web/views/error_helpers.ex instead of web/gettext.ex"
  * http://blog.plataformatec.com.br/2016/04/ecto-2-0-0-rc-is-out/
  ** "Ecto 2.0 now requires an explicit :ecto_repos configuration for running tasks like ecto.migrate and others. Open up your config/config.exs and add:"
  ````elixir
  config :offshore, ecto_repos: [Offshore.Repo]
  ````

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix