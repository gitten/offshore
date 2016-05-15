# Offshore

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Notes:
  * Learned how to load CSV data into Ecto from @wsmoak:

    http://wsmoak.net/2016/02/16/phoenix-ecto-seeds-csv.html

    https://github.com/wsmoak/minty/blob/master/priv/repo/seeds.exs

## Bump to Phoenix 1.2-rc w/ Ecto 2.0.0-rc
  * https://gist.github.com/chrismccord/29100e16d3990469c47f851e3142f766

    "...translate_error function was found in web/views/error_helpers.ex instead of web/gettext.ex"

  * http://blog.plataformatec.com.br/2016/04/ecto-2-0-0-rc-is-out/

    "Ecto 2.0 now requires an explicit :ecto_repos configuration for running tasks like ecto.migrate and others. Open up your config/config.exs and add:"

    ````elixir
    config :offshore, ecto_repos: [Offshore.Repo]
    ````

## Generate

You can run the `priv/repo/panana_seeds.exs` script after putting the csv data files in `priv/repo/data`. Download the data from the [ICIJ website](https://offshoreleaks.icij.org/pages/database).

Before loading the data, you'll need to create the tables an Ecto schemas. YMMV, but you can use the generators if you want controllers and views too.

  * mix phoenix.gen.html Address addresses address icij_id valid_until country_codes countries node_id:integer:unique sourceID
  * mix phoenix.gen.html Intermediary intermediaries name internal_id address valid_until country_codes countries status node_id:integer:unique sourceID
  * mix phoenix.gen.html Officer officers name icij_id valid_until country_codes countries node_id:integer:unique sourceID
  * mix phoenix.gen.html Entity entities name original_name former_name jurisdiction jurisdiction_description company_type address internal_id incorporation_date:date inactivation_date:date struck_off_date:date dorm_date:date status service_provider ibcRUC country_codes countries note valid_until node_id:integer:unique sourceID
  * mix phoenix.gen.html Edge edges node_1:integer rel_type node_2:integer
  
## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
