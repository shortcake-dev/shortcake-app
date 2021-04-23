########################
🍰 Shortcake Flutter App
########################

.. image:: https://img.shields.io/github/workflow/status/shortcake-dev/shortcake-app/tests/main?label=tests&style=for-the-badge
  :target: https://github.com/shortcake-dev/shortcake-app/actions/workflows/tests.yml
.. image:: https://img.shields.io/github/workflow/status/shortcake-dev/shortcake-app/linting/main?label=linting&style=for-the-badge
  :target: https://github.com/shortcake-dev/shortcake-app/actions/workflows/linting.yml

Flutter app for the Shortcake_ backend

.. _Shortcake: https://github.com/shortcake-dev/shortcake

###########
Development
###########

*******
Codegen
*******

This project uses Ferry_ for strongly-typed GraphQL Dart requests and objects. Unfortunately, it
requires codegen to function.

The codegen requires the GraphQL schema (that's used in the backend). The current version of the
schema the client is built against is located at :code:`bin/src/graphql/schema.graphql`. (In the
future, this may removed in lieu of a better process. Steps 1 and 2 below are optional unless the
upstream schema has been updated.

1. Get the GraphQL schema.

   .. code-block:: bash

       SHORTCAKE_APP_DIR=$(pwd)

       git clone https://github.com/shortcake-dev/shortcake.git /tmp/shortcake
       cd /tmp/shortcake
       poetry install

   Then, run the the following Python code to print the schema

   .. code-block:: python

       from strawberry.printer import print_schema
       from shortcake.api.graphql import schema;

       print_schema(schema)

2. Copy and paste the output to :code:`${SHORTCAKE_APP_DIR}/bin/src/graphql/schema.graphql`

3. Then, generate the code

   .. code-block:: bash

       flutter pub run build_runner build --delete-conflicting-outputs


.. _Ferry: https://github.com/gql-dart/ferry