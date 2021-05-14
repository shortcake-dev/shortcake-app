import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:gql_exec/gql_exec.dart' hide Operation;
import 'package:provider/provider.dart';
import 'package:shortcake_app/graphql/api_client.dart';

class GraphQLWidget<TData, TVars> extends StatefulWidget {
  final OperationRequest<TData, TVars> operationRequest;

  final Widget Function(TData data) onData;
  final Widget Function(TData? data) onLoading;
  final Widget Function(Object error) onRuntimeError;
  final Widget Function(LinkException exception) onLinkException;
  final Widget Function(List<GraphQLError> graphQLErrors) onGraphQLErrors;

  GraphQLWidget({
    required this.operationRequest,
    required this.onData,
    required this.onLoading,
    this.onRuntimeError = _onRuntimeError,
    this.onLinkException = _onLinkException,
    this.onGraphQLErrors = _onGraphQLErrors,
  });

  static Widget _onRuntimeError(Object error) {
    return Text('Runtime Error: $error');
  }

  static Widget _onGraphQLErrors(List<GraphQLError> graphQLErrors) {
    return Text('GraphQL Errors: $graphQLErrors');
  }

  static Widget _onLinkException(LinkException exception) {
    return Text('Link Exception: $exception');
  }

  @override
  _GraphQLWidgetState<TData, TVars> createState() => _GraphQLWidgetState();
}

class _GraphQLWidgetState<TData, TVars>
    extends State<GraphQLWidget<TData, TVars>> {
  @override
  Widget build(BuildContext context) {
    return Operation<TData, TVars>(
      client: Provider.of<ShortcakeApi>(context, listen: false),
      operationRequest: widget.operationRequest,
      builder: (
        BuildContext context,
        OperationResponse<TData?, TVars?>? response,
        Object? error,
      ) {
        if (error != null) {
          return widget.onRuntimeError(error);
        }

        // If error != null, response must be non-null
        response!;

        if (response.linkException != null) {
          return widget.onLinkException(response.linkException!);
        }
        if (response.graphqlErrors != null) {
          return widget.onGraphQLErrors(response.graphqlErrors!);
        }

        if (response.loading) {
          return widget.onLoading(response.data);
        }

        // If no errors and not loading, response.data must be non-null
        return widget.onData(response.data!);
      },
    );
  }
}
