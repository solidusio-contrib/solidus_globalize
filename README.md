# Solidus Globalize

[![Build Status](https://travis-ci.org/solidusio-contrib/solidus_globalize.svg?branch=master)](https://travis-ci.org/solidusio-contrib/solidus_globalize)
[![Code Climate](https://codeclimate.com/github/solidusio-contrib/solidus_globalize/badges/gpa.svg)](https://codeclimate.com/github/solidusio-contrib/solidus_globalize)

This is the globalization project for [Solidus][1].

**NOTE:** If you just need to change the language of your store, and will only
have data in database in one language, then you don't need this gem, use [solidus_i18n][8],
which provides translations for static content (links, headers etc).

This gem adds the **model data** translation support using the [Globalize][3] gem.
[Read more](#model-translations)

Happy translating!

---

## Installation

For Solidus 2.0+, add the following to your `Gemfile`:

```ruby
gem 'globalize', github: 'globalize/globalize'
gem 'solidus_i18n', github: 'solidusio-contrib/solidus_i18n'
gem 'solidus_globalize', github: 'solidusio-contrib/solidus_globalize'
```

For Solidus 1.x, add the following instead:

```ruby
gem 'globalize', '~> 5.0.0'
gem 'solidus_i18n', github: 'solidusio-contrib/solidus_i18n'
gem 'solidus_globalize', github: 'solidusio-contrib/solidus_globalize'
```

Run `bundle install`

You can use the generator to install migrations and append solidus_globalize assets to
your app solidus manifest file.

    bin/rails g solidus_globalize:install

This will insert these lines into your solidus manifest files:

```
vendor/assets/javascripts/spree/backend/all.js
//= require spree/backend/solidus_globalize

vendor/assets/stylesheets/spree/frontend/all.css
*= require spree/backend/solidus_globalize
```

---

## Model Translations

This feature uses the [Globalize][3] gem to localize model data.
So far the following models are translatable:

    Product, Promotion, OptionType, Taxonomy, Taxon, Property and ShippingMethod.

Start your server and you should see a TRANSLATIONS link or a flag icon on each
admin section that supports this feature.

There are two configs that allow users to customize which locales
should be displayed as options on the translation forms and which should be
listed to customers on the frontend. You can set them on an initializer. e.g.

```ruby
SolidusI18n::Config.available_locales = [:en, :es, :'pt-BR'] # displayed on frontend select box
SolidusGlobalize::Config.supported_locales = [:en, :'pt-BR'] # displayed on translation forms
```

PS. Please use symbols, not strings. e.g. `:'pt-BR'` not just `'pt-BR'`. Otherwise
you may get unexpected errors

Or if you prefer they're also available on the admin UI general settings section.

*Every record needs to have a translation. If by any chance you remove `solidus_globalize`
from your Gemfile, add some records and then add `solidus_globalize` gem back you might get
errors like ``undefined method for nilClass`` because Globalize will try fetch
translations that do not exist.*

---

## Contributing

[See corresponding guidelines][7]

---

Copyright (c) 2010-2015 [Spree Commerce Inc.][1] and other [contributors][5]. released under the [New BSD License][6]

[1]: https://solidus.io
[2]: http://guides.spreecommerce.com/developer/i18n.html
[3]: https://github.com/globalize/globalize
[5]: https://github.com/solidusio-contrib/solidus_globalize/graphs/contributors
[6]: https://github.com/solidusio-contrib/solidus_globalize/blob/master/LICENSE.md
[7]: https://github.com/solidusio-contrib/solidus_globalize/blob/master/CONTRIBUTING.md
[8]: https://github.com/solidusio-contrib/solidus_i18n
