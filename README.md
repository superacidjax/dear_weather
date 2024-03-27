# Welcome to Dear Weather

This app assumes you've installed Ruby 3.2.2.

Getting Started

1. ```bundle && bundle exec rake db:create && bundle exec rake db:migrate && rspec```
Assuming the rspec is green..
2. ```gem install foreman && foreman start```
3. Open ```localhost:3000``` in a browser

And you should be all set.

This application supports US and international locations.

Potential Future Features

1. Localization
2. Extended forecasts
3. Pressure trends (i.e. is the barometric pressure trending up or down which can be useful for predictions.)
4. Historical Data
5. User accounts with favorites
6. Improved UI design
