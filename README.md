# Strava Webhooks Boilerplate

This is a barebones Sinatra app to get you started with Strava's V3 API webhooks.

There are some language agnostic [docs](https://developers.strava.com/docs/webhooks/), but this is intended to get you going with a Ruby app.

# Set up

## Ngrok setup

* Sign up at [ngrok](https://ngrok.com/).
* `brew cask install ngrok`
* `ngrok authtoken YOUR_AUTH_TOKEN` (find it [here](https://dashboard.ngrok.com/get-started))

## Strava app setup

Walk through the steps of creating a new [Strava App](https://www.strava.com/settings/api).

You should now have a `Client ID` and a `Client Secret`. Hold on to it, because we'll need it later.

## Connect it all together

`bundle install`
`bundle exec rackup`

In a new tab:

`ngrok http 9292`

Copy the url `Forwarding` line. It should look something like this: `Forwarding https://07590f65.ngrok.io -> localhost:9292`

In a new tab:

```
curl -X POST https://api.strava.com/api/v3/push_subscriptions \
      -F client_id=CLIENT_ID \
      -F client_secret=CLIENT_SECRET \
      -F 'callback_url=CLIENT_CALLBACK_URL' \
      -F 'verify_token=STRAVA'
```

## Test it out

Create a new [manual entry](https://www.strava.com/upload/manual) in Strava.
If all went well, you should see something like the following in the console:

`{"aspect_type"=>"create", "event_time"=>1517893323, "object_id"=>1393793516, "object_type"=>"activity", "owner_id"=>27852846, "subscription_id"=>121064, "updates"=>{}}`