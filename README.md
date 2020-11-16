# Poke Trader
*Disclaimer: For this documentantion I'm going to be using English only for practicity and further use, but in my understanding, inside teams documentations should be written with everyone's understanding as target*

This app can be found running on production environment at [http://poke-trader-app.herokuapp.com/](http://poke-trader-app.herokuapp.com/)

---

# Summary
- [Project short description](#project-short-description)
- [Running locally](#running-locally)
- [Stack used](#stack-used)
- [Design and Archtecture](#design-and-archtecture)
- [Tests](#tests)



---

## Project short description
The goal of this project is to *manage* **Pokemon trades**, this includes validate if the **trade is fair** and both sender and receiver are giving **between 1 and 6 pokemons** each.

## Running locally
There's three ways to run this project locally:

#### 1. All native
In order to run this all native you shall have a postgreSQL instance running and set it's addres at the `.env` file.
After this you can run `bundle install` followed by `rails db:create && rails db:migrate` and then just run the server with `rails s`

#### 2. With docker
To run with docker you need docker and docker-compose installed and then just run `docker-compose up --build`, the server will be up at port `80` (*http://localhost/*)

#### 3. Hybrid
Having databases locally can be really bad, so if you have ruby 2.6 and don't want to install a postgres you can run `docker-compose run -d db` and `docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_id` to get the IP address of this DB instance. After that just follow the **All native** steps.

---

## Stack used
I've chosen use **Ruby on Rails**, **React** and **postgreSQL** for this project.
This decision was led by past experiences:

**RoR**: I work with Rails daily and I'm really confortable with it. Also is a good way to demonstrate my proficiency with a technology used by the company.

**React**: I've worked with react native for about 7 months before, and recently started to use Vue with rails and tested also *react*, so it wasn't a complete new environment to me.

**postgreSQL**: Postgres is a Database which I've worked with before and heroky accepts =)

**Rspec**: It's the main gem I've use to test with rails since always.

---

## Design and Archtecture
There's some time I've beign studying good practices, designs and trying to improve with my archtecture decisions, this is a result of the past years of work and much internal(and external) discussions.
Much of this code is influence by *Uncle bob* **Clean Code** and **Clean Archtecture**, as well as some definitions of *dry* and *domain knowledge* by *Andy Hunt* and *Dave Thomas* in the **pragmatic programmer** and, recently, by *Jay Fields* with his **DAMP** definition which can be found on [his book about tests](https://leanpub.com/wewut).

But without further ado, the project can be devided by traditional *MVC* and a "rest-like" *API* with a *React* front-end, also it has some layers which must be respected to maintain the readability, beign they created with:

- Interactors
- Adapters

#### Interactors
The main pourpose of this interactors is to remove any logic of the controllers as well as concentrate their *domain knowledge* in one place. It's use isn't strict to `controllers`, interactors may use other interactors with a specific *knowledge* but no other layer may interact with them. In another words they orchestrate an algorithm.

*Cool note: After many discussions with other developers I've got the conclusion that a method with an **call to action** is easier to read and understand than the usual `.call` at interactors.*

#### Adapters
In order to create a single point of contact/interface of external repositories and internal representations(*pokemon model* in this case) I've created and adapter which receives any info needed to build the entity which the adapter is for. This grants that if at any moment the repository or the data set receive changes, the only other point that must be modified is the adapter.


**About the mvc and react**

After some thougth I concluded that the usual MVC rails project would not get to the result I wanted for the usability. Beign that so, I decided to use Rails to manage all page render and form actions, but to have a more fluid and easy to use experience was created an `api/v1` path to use with **React**. This, unfortunatly, makes the *react component* have much of the business logic and is a risk I'm willing to take.

---

## Tests
  I've decided to use integration and unit tests togther at spec files, also, thinking in a **descriptive** approach all `it` have the necessary setup to understand the tests.

