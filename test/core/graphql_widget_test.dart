import 'package:ferry/ferry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:shortcake_app/core/graphql_widget.dart';
import 'package:shortcake_app/feature/homepage/graphql/recipe_summaries.data.gql.dart';
import 'package:shortcake_app/feature/homepage/graphql/recipe_summaries.req.gql.dart';
import 'package:shortcake_app/graphql/api_client.dart';

import '../test_core/mock.dart';

class TestGraphQLWidget extends StatelessWidget {
  final ShortcakeApi shortcakeApi;
  final GraphQLWidget graphQLWidget;

  const TestGraphQLWidget({
    required this.shortcakeApi,
    required this.graphQLWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Provider<ShortcakeApi>.value(
        value: shortcakeApi,
        child: graphQLWidget,
      ),
    );
  }
}

void main() {
  group('GraphQLWidget', () {
    late MockApi mockApi;

    late OperationRequest req;
    late GRecipeSummariesData result;

    late TestGraphQLWidget testWidget;

    setUp(() {
      mockApi = MockApi();
      req = GRecipeSummariesReq();
      result = GRecipeSummariesData(
        (b) => b
          ..recipes.add(GRecipeSummariesData_recipes(
            (c) => c
              ..name = 'This is a recipe'
              ..id = 'This is an id',
          )),
      );
    });

    testWidgets('calls onData when request is complete', (tester) async {
      testWidget = TestGraphQLWidget(
        shortcakeApi: mockApi,
        graphQLWidget: GraphQLWidget(
          operationRequest: req,
          onData: (data) => Text('The data: $data'),
          onLoading: (data) => Text('unused'),
        ),
      );

      when(() => mockApi.request(req))
          .thenAnswer((_) => Stream.value(OperationResponse(
                operationRequest: req,
                data: result,
              )));
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      expect(find.text('The data: $result'), findsOneWidget);
    });

    testWidgets('calls onLoading when request is loading,', (tester) async {
      const loadingString = 'It be loading';

      testWidget = TestGraphQLWidget(
        shortcakeApi: mockApi,
        graphQLWidget: GraphQLWidget(
          operationRequest: req,
          onData: (data) => Text('unused'),
          onLoading: (data) => Text(loadingString),
        ),
      );

      when(() => mockApi.request(req)).thenAnswer(
        (_) => Stream.value(OperationResponse(
          operationRequest: req,
          data: result,
        )),
      );

      await tester.pumpWidget(testWidget);

      expect(find.text(loadingString), findsOneWidget);
    });

    testWidgets('passes data to onLoading', (tester) async {
      markTestSkipped('Not sure how to get data while loading');

      testWidget = TestGraphQLWidget(
        shortcakeApi: mockApi,
        graphQLWidget: GraphQLWidget(
          operationRequest: req,
          onData: (data) => Text('unused'),
          onLoading: (data) => Text('Request loading: $data'),
        ),
      );

      when(() => mockApi.request(req)).thenAnswer(
        (_) => Stream.value(OperationResponse(
          operationRequest: req,
          data: result,
        )),
      );

      await tester.pumpWidget(testWidget);

      expect(find.text('Request loading: $result'), findsOneWidget);
    }, skip: true);

    group('on runtime error', () {
      late Exception error;

      setUp(() {
        error = Exception('oops');

        when(() => mockApi.request(req)).thenAnswer(
          (_) => Stream.error(error),
        );
      });

      testWidgets(
        'calls _onRuntimeError when no function provided',
        (tester) async {
          testWidget = TestGraphQLWidget(
            shortcakeApi: mockApi,
            graphQLWidget: GraphQLWidget(
              operationRequest: req,
              onData: (data) => Text('unused'),
              onLoading: (data) => Text('unused'),
            ),
          );

          await tester.pumpWidget(testWidget);
          await tester.pumpAndSettle();

          expect(find.text('Runtime Error: $error'), findsOneWidget);
        },
      );

      testWidgets(
        'calls onRuntimeError when function provided',
        (tester) async {
          testWidget = TestGraphQLWidget(
            shortcakeApi: mockApi,
            graphQLWidget: GraphQLWidget(
              operationRequest: req,
              onData: (data) => Text('unused'),
              onLoading: (data) => Text('unused'),
              onRuntimeError: (error) => Text('A runtime error: $error'),
            ),
          );

          await tester.pumpWidget(testWidget);
          await tester.pumpAndSettle();

          expect(find.text('A runtime error: $error'), findsOneWidget);
        },
      );
    });

    group('on LinkException', () {
      late LinkException exception;

      setUp(() {
        exception = ResponseFormatException(
          originalException: Exception('oops'),
        );

        when(() => mockApi.request(req)).thenAnswer(
          (_) => Stream.value(OperationResponse(
            operationRequest: req,
            linkException: exception,
          )),
        );
      });

      testWidgets(
        'calls _onLinkException when no function provided',
        (tester) async {
          testWidget = TestGraphQLWidget(
            shortcakeApi: mockApi,
            graphQLWidget: GraphQLWidget(
              operationRequest: req,
              onData: (data) => Text('unused'),
              onLoading: (data) => Text('unused'),
            ),
          );

          await tester.pumpWidget(testWidget);
          await tester.pumpAndSettle();

          expect(find.text('Link Exception: $exception'), findsOneWidget);
        },
      );

      testWidgets(
        'calls onLinkException when function provided',
        (tester) async {
          testWidget = TestGraphQLWidget(
            shortcakeApi: mockApi,
            graphQLWidget: GraphQLWidget(
              operationRequest: req,
              onData: (data) => Text('unused'),
              onLoading: (data) => Text('unused'),
              onLinkException: (exception) =>
                  Text('A link exception: $exception'),
            ),
          );

          await tester.pumpWidget(testWidget);
          await tester.pumpAndSettle();

          expect(find.text('A link exception: $exception'), findsOneWidget);
        },
      );
    });

    group('on GraphQL error', () {
      late List<GraphQLError> errors;

      setUp(() {
        errors = [GraphQLError(message: 'some error')];

        when(() => mockApi.request(req)).thenAnswer(
          (_) => Stream.value(OperationResponse(
            operationRequest: req,
            graphqlErrors: errors,
          )),
        );
      });

      testWidgets(
        'calls _onGraphQLErrors when no function provided',
        (tester) async {
          testWidget = TestGraphQLWidget(
            shortcakeApi: mockApi,
            graphQLWidget: GraphQLWidget(
              operationRequest: req,
              onData: (data) => Text('unused'),
              onLoading: (data) => Text('unused'),
            ),
          );

          await tester.pumpWidget(testWidget);
          await tester.pumpAndSettle();

          expect(find.text('GraphQL Errors: $errors'), findsOneWidget);
        },
      );

      testWidgets(
        'calls onGraphQLErrors when function provided',
        (tester) async {
          testWidget = TestGraphQLWidget(
            shortcakeApi: mockApi,
            graphQLWidget: GraphQLWidget(
              operationRequest: req,
              onData: (data) => Text('unused'),
              onLoading: (data) => Text('unused'),
              onGraphQLErrors: (errors) => Text('Some GraphQL errors: $errors'),
            ),
          );

          await tester.pumpWidget(testWidget);
          await tester.pumpAndSettle();

          expect(find.text('Some GraphQL errors: $errors'), findsOneWidget);
        },
      );
    });
  });
}
