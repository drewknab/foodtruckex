# Foodtruck

## Objective
Write a tiny self-contained Elixir app that uses OTP to handle the data layer and emphasise docs and testing rather than elaborate APIs.
Lean towards extremely thin controllers that pull logic from a small core library of composable functions.
Do this in one weekend, in about 3 hours.

## API
The api will live at [`localhost:4000/truck/random`](http://localhost:4000/truck/random) it will also accept a filter query string parameter of ?food={food}

## Overview
At startup the application consumes a CSV full of food truck data.
This application that takes a useful subset of that data and stores it in an agent.
Alternatively we easily could have stored it in ETS or a real database like Postgres.
Agent is the simplest option in terms of implementation. That was important given the time constraint (4 hours).
I think it probably would have been better to implement ETS tables. There is some inefficiency present in having to
directly filter the data pulled out of the Agent.

## Data
I made some fairly basic assumptions about the data. Namely that it's static.
In the real world that is obviously not the case.
I think with some minor tweaks the central idea of using and Agent as a "persistance" model could support dynamic data.
At the very least it would need some cron-like job running to consume freshly exported data.
Once I had the Truck struct in mind the shape of the data flowing through the system didn't alter much.
That appears to be a decent domain decision.
Theoretically it could just be a map, but I like the idea of having compile time issues instead of production ones.

## Testing
The application ended up with a rough 29.59% coverage. The percentage took some hits thanks to the default Phoenix views.
I think they probably ought to be either politely ignored in tests or overhauled and replaced with real layouts with real tests.
The rest of the application got high marks. Using Application.fetch_env to handle the file name worked well. I was able to specify
the file name as being different between environments. Directly made code more testable, with less elbow grease.

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

  * Run `mix test` to run the test suite.
