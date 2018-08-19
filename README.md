# Grandma's Recipes

[![Build Status](https://travis-ci.com/yizeng/grandmas-recipes.svg?branch=master)](https://travis-ci.com/yizeng/grandmas-recipes)

## Problem

Grandma wants to store all of her family recipes but keeps losing her old recipe book. We're bringing grandma into the digital age by building her a web app where she can keep her recipes on the web!

## Solution

A Ruby on Rails based web application was created to provide grandma such needs.

### Demo

[https://grandmas-recipes.herokuapp.com/](https://grandmas-recipes.herokuapp.com/)

Hosted on Heroku with a free dyno, it auto shuts down after 30 minutes of inactivity, please expect delays on initial page load

### Design Principles
- API First (a separation between API and UI)
- Mobile Friendly and easy-accessible for elderly (poorly done in this iteration due to time constraints)

### Backend

- Ruby on Rails (with an API can be extracted to an independent API server)
- PostgreSQL

#### API Endpoints

| Verb | URI | Action |
| --- | --- | --- |
| GET | /api/recipes | api/recipes#index |
| GET | /api/recipes/:id | api/recipes#show |
| POST | /api/recipes | api/recipes#create |
| PATCH | /api/recipes/:id | api/recipes#update |
| DELETE | /api/recipes/:id | api/recipes#destroy |

#### DB Design

![TODO-DB-Design-Picture](/public/DB-Design.jpg)

### Frontend

Although ReactJS was initially considered because
1. slick and better user experience - Grandma likes a fancy and easy to use UI
1. better runtime performance - Grandma hates the slow internet and irresponsive UI
1. separated UI layer - Not that Grandma cares, but it makes maintenance easier
1. non-opinionated to have the freedom to choose tools and technologies
1. easy migration to mobile apps via React Native - Grandma doesn't want to carry a laptop while cooking
1. popularity - Grandma's other grandchildren know how to use React too and can help in developing it!

but the iteration 1 of the UI is done using simple Boostrap/jQuery as a safe bet to make this prototype usable at least within the timeframe.

### CI/CD

- Code is source controlled using Git and hosted on GitHub: [GitHub - yizeng/grandmas-recipes](https://github.com/yizeng/grandmas-recipes)
- CI done via Travis CI (built-in to GitHub): [Travis CI - Grandma's Recipes](https://travis-ci.com/yizeng/grandmas-recipes/builds)
- Hosted and deployed to Heroku and can be accessed at (on a free dyno, it auto shuts down after 30 minutes of inactivity, please expect delays on initial page load): [Grandma's Recipes](https://grandmas-recipes.herokuapp.com/)

### Features done in iteration 1

- Allow Grandma to add new recipes
- Allow Grandma to see a list of recipes
- Allow Grandma to edit an existing recipe
- Allow Grandma to view an existing recipe
- Allow Grandma to remove an existing recipe
- Full API support for recipes (except for recipe photos and tags)

### Limitations

- The DB was designed to have the ability to upload photos and tags recipes, but not yet implemented in API or UI.
- UI was done using jQuery/Bootstrap (as a safe bet to complete the challenge within the challenged timeframe)
- No field validations in all modal popups (backend validation is in place of course)
- Ugly JavaScipt alerts for all form submission feedbacks
- Not so much mobile friendly and easy-accessible for elderly yet
- Messy and duplicated JS code and modal partials
- No Rails system tests (UI tests) added (however 25 RSpec unit tests were created)
- The list of recipes can't be searched, sorted or paginated.
- Steps and ingredients are currently just simple text fields. Ideally, ingredients should be DB entities that can be cross-referenced by different recipes. Steps should be separated and can be re-ordered.

### Future Plans (if there's additional time)

#### DB
- Create ingredients table
- Make steps more flexible that can be re-ordered, instead of a simple text.
- Extend recipes table for servings and cooking time needed.

#### API
- Finish off API for recipe photos and tags
- API for ingredients

#### UI
- Allow adding/deleting photos to recipes
- Allow tagging/untagging recipes
- Allow searching/sorting recipes by tags
- Allow searching/sorting recipes by ingredients
- Allow adding servings and cooking time information to recipes.
- Allow favoriting recipes

#### Nice to have
- Multi-user support (Grandpa sees this app and wants to add few of his favorite recipes too, but hopes to keep them separate from Grandma's!)
- I18n (Grandma's distant cousin from Brazil comes to visit and would like add a few special Brazilian cuisines, but couldn't understand English)
