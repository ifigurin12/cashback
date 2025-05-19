import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum CategorySource {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('user')
  sourceuser('user'),
  @JsonValue('bank')
  sourcebank('bank');

  final String? value;

  const CategorySource(this.value);
}

enum UserRoleType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('default')
  $default('default'),
  @JsonValue('admin')
  admin('admin');

  final String? value;

  const UserRoleType(this.value);
}
