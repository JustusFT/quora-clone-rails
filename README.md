# Quora clone rails

A clone of the Q&A site Quora powered by Ruby on Rails.

View the app live here: https://whispering-plains-50835.herokuapp.com/

Some functionality includes:

- User registration
- Creating questions
- Creating answers to questions
- Creating comments to answers or other comments (recursive comments)
- Tagging questions with topics

# Setup

Follow these instructions if you want to setup a local instance of this app.

### Prerequisites

The following must be installed on your machine:

| Dependency | Version |
| ---------- | ------- |
| Ruby       | 2.5.1   |
| PostgreSQL | 10.5    |

### Installation

1. Clone and cd into the github repository

```sh
git clone https://github.com/JustusFT/quora-clone-rails.git
cd quora-clone-rails
```

2. Install dependencies

```sh
bundle
```

3. Setup the database

```sh
rails db:{create,migrate}
```

**Optional:** Seed the database with data

```sh
rails db:seed
```

4. Start the server

```sh
rails s
```

The server should now be open on `localhost:3000`

### Testing

Run the specs with

```sh
rails spec
```
