# Solidus Globalize

[![CircleCI](https://circleci.com/gh/solidusio-contrib/solidus_globalize/tree/master.svg?style=svg)](https://circleci.com/gh/solidusio-contrib/solidus_globalize/tree/master)[![Code Climate](https://codeclimate.com/github/solidusio-contrib/solidus_globalize/badges/gpa.svg)](https://codeclimate.com/github/solidusio-contrib/solidus_globalize)

This is the globalization project for [Solidus][1].

**NOTE:** If you just need to change the language of your store, and will only
have data in database in one language, then you don't need this gem,
use [solidus_i18n][8], which provides translations for static content (links,
headers etc).

This gem adds the **model data** translation support using the [Globalize][3] gem.
[Read more](#model-translations)

Happy translating!

---

## Installation

Add the following to your `Gemfile`:

```ruby
gem 'solidus_globalize', github: 'solidusio-contrib/solidus_globalize'
```

Run `bundle install`

You can use the generator to install migrations and append solidus_globalize assets to
your app solidus manifest file.

    bin/rails g solidus_globalize:install

This will insert this line into your solidus manifest file
(`vendor/assets/javascripts/spree/backend/all.js`):

```js
//= require spree/backend/solidus_globalize
```

---

## Model Translations

This feature uses the [Globalize][3] gem to localize model data.
So far the following models are translatable:

    Product, Promotion, OptionType, Taxonomy, Taxon, Property and ShippingMethod.

Start your server and you should see a TRANSLATIONS link or a flag icon on each
admin section that supports this feature.

To enable adding translations in admin for a specific language you have to set
into an initializer:

```ruby
SolidusGlobalize::Config.supported_locales = [:en, :'pt-BR']
```

**PS 1.** The languages you add to this configuration need to be supported by
your store. This means that you need to have a transations file for them
into `/config/locales/` (eg. `/config/locales/pt-BR.yml`).

**PS 2.** Please use symbols, not strings. e.g. `:'pt-BR'` not just `'pt-BR'`.
Otherwise you may get unexpected errors

Or if you prefer they're also available on the admin UI general settings section.

*Every record needs to have a translation. If by any chance you remove `solidus_globalize`
from your Gemfile, add some records and then add `solidus_globalize` gem back you might get
errors like ``undefined method for nilClass`` because Globalize will try fetch
translations that do not exist.*

---

## Contributing

[See corresponding guidelines][7]

---

Copyright (c) 2020 [Soldius][1] and other [contributors][5].
Released under the [New BSD License][6]

[1]: https://solidus.io
[3]: https://github.com/globalize/globalize
[5]: https://github.com/solidusio-contrib/solidus_globalize/graphs/contributors
[6]: https://github.com/solidusio-contrib/solidus_globalize/blob/master/LICENSE.md
[7]: https://github.com/solidusio-contrib/solidus_globalize/blob/master/CONTRIBUTING.md
[8]: https://github.com/solidusio-contrib/solidus_i18n
