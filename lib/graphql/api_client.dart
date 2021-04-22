import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';

class ShortcakeApi extends Client {
  final String uri;

  ShortcakeApi(this.uri) : super(link: HttpLink(uri));
}
