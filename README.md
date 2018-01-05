# Grav Experiment

## Running this

Clone the repo and run

1. ```docker build -t grav-experiment .```
1. ```docker run -it -p 5000:5000 grav-experiment```

Then open your browser to http://localhost:5000

## Using Admin

You need to ask me for the admin password

## Why I did this

This shows a very basic usage of Grav with one of the ready-to-go skeletons
The interesting part of this is to show an alternative to the "docs" page for the Dev Portal

It provides a left hand navigation, ability to add more content online instead of only github
And I wrote a tiny plugin that is able to fetch markdown from a remote url and render it inline on a page
In this case the markdown is coming from one of my public repos just because I don't want to hassle
with handling authentication / access to a private workiva GH repo

The Dockerfile has comments about the nuts and bolts
