########################
🍰 Shortcake Flutter App
########################

.. image:: https://img.shields.io/github/workflow/status/shortcake-dev/shortcake-app/tests/main?label=tests&style=for-the-badge
  :target: https://github.com/shortcake-dev/shortcake-app/actions/workflows/tests.yml

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

1. First, you need to get the GraphQL schema. (This process *really* needs to be improved. See #???)

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