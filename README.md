# Pokemon

## Running the Project

  1. Install dependencies

  ```bash
  mix deps.get
  ```

  2. Setup a docker container for postgres

  ```bash
   docker run --name postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres
  ```

  3. Create and migrate your database

  ```bash
  mix ecto.setup
  ```

  4. Start Phoenix endpoint

  ```bash
  mix phx.server
  ```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Making API requests

After the project is running, you can make API request to the available endpoints. At the moment we have the following endpoints:

### get name

Using this endpoint you can get the name of a pokemon by its id in the Poke api.

  ```bash
  curl -X GET http://localhost:4000/api/name/:pokeapi_id
  ```

Example:

  ```bash
  > curl -X GET http://localhost:4000/api/name/132

  {"data":{"name":"ditto"}}%
  ```

### get pokeapi_id

Using this endpoint you can get the id of a pokemon in the Poke api by its name.

  ```bash
  curl -X GET http://localhost:4000/api/pokeapi_id/:name
  ```

Example:

  ```bash
  > curl -X GET http://localhost:4000/api/pokeapi_id/ditto

 {"data":{"pokeapi_id":"132"}}%
  ```

## Running tests

To run the test suite, make sure you have the postgres container up and run

  ```bash
  mix test
  ```
