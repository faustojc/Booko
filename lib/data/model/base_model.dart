import 'package:booko/data/model/mixin/query_builder.dart';

abstract class BaseModel<T> with QueryBuilder<T> {
  @override
  String get documentName;

  Map<String, dynamic> toJson();
}
