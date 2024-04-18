import 'package:cloud_firestore/cloud_firestore.dart';

mixin QueryBuilder<T> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Map<String, dynamic>> _whereClauses = [];

  String _orderBy = '';
  int _limit = 0;

  dynamic _startAt;
  dynamic _endAt;
  dynamic _startAfter;
  dynamic _endBefore;

  T fromJson(Map<String, dynamic> json);

  String get documentName;

  Future<void> update(Map<String, dynamic> data) async {
    assert(_whereClauses.isNotEmpty, 'Cannot update without a where clause');

    final clause = _whereClauses.first;

    if (clause['operator'] != '==') {
      throw Exception('Update operation only supports equality checks');
    }

    await _firestore.collection(this.documentName).doc(clause['value']).update(data);
  }

  Future<DocumentReference> insert(Map<String, dynamic> data) async {
    return await _firestore.collection(this.documentName).add(data);
  }

  Future<void> delete() async {
    if (_whereClauses.isEmpty) {
      throw Exception('Cannot delete without a where clause');
    }

    final clause = _whereClauses.first;
    if (clause['operator'] != '==') {
      throw Exception('Delete operation only supports equality checks');
    }

    await _firestore.collection(this.documentName).doc(clause['value']).delete();
  }

  QueryBuilder<T> where({required String field, required String operator, required String value}) {
    _whereClauses.add({'field': field, 'operator': operator, 'value': value});
    return this;
  }

  QueryBuilder<T> orderBy(String field, {bool descending = false}) {
    _orderBy = field;
    return this;
  }

  QueryBuilder<T> limit(int count) {
    _limit = count;
    return this;
  }

  QueryBuilder<T> startAt(dynamic value) {
    _startAt = value;
    return this;
  }

  QueryBuilder<T> endAt(dynamic value) {
    _endAt = value;
    return this;
  }

  QueryBuilder<T> startAfter(dynamic value) {
    _startAfter = value;
    return this;
  }

  QueryBuilder<T> endBefore(dynamic value) {
    _endBefore = value;
    return this;
  }

  Future<List<T>> get() async {
    Query query = _firestore.collection(this.documentName);

    for (Map<String, dynamic> clause in _whereClauses) {
      switch (clause['operator']) {
        case '==':
          query = query.where(clause['field'], isEqualTo: clause['value']);
          break;
        case '<':
          query = query.where(clause['field'], isLessThan: clause['value']);
          break;
        case '<=':
          query = query.where(clause['field'], isLessThanOrEqualTo: clause['value']);
          break;
        case '>':
          query = query.where(clause['field'], isGreaterThan: clause['value']);
          break;
        case '>=':
          query = query.where(clause['field'], isGreaterThanOrEqualTo: clause['value']);
          break;
        case 'array-contains':
          query = query.where(clause['field'], arrayContains: clause['value']);
          break;
        case 'array-contains-any':
          query = query.where(clause['field'], arrayContainsAny: clause['value']);
          break;
        case 'in':
          query = query.where(clause['field'], whereIn: clause['value']);
          break;
        case 'not-in':
          query = query.where(clause['field'], whereNotIn: clause['value']);
          break;
      }
    }

    if (_orderBy.isNotEmpty) {
      query = query.orderBy(_orderBy);
    }

    if (_limit > 0) {
      query = query.limit(_limit);
    }

    if (_startAt != null) {
      query = query.startAt([_startAt]);
    }

    if (_endAt != null) {
      query = query.endAt([_endAt]);
    }

    if (_startAfter != null) {
      query = query.startAfter([_startAfter]);
    }

    if (_endBefore != null) {
      query = query.endBefore([_endBefore]);
    }

    final snapshots = await query.get();
    return snapshots.docs.map((doc) => fromJson(doc.data() as Map<String, dynamic>)).toList();
  }
}
