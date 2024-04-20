import 'package:cloud_firestore/cloud_firestore.dart';

mixin QueryBuilder<T> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Map<String, dynamic>> _whereClauses = [];

  String _orderBy = '';
  bool _descending = false;
  int _limit = 0;

  dynamic _startAt;
  dynamic _endAt;
  dynamic _startAfter;
  dynamic _endBefore;

  T fromJson(Map<String, dynamic> json);

  String get collectionName;

  /// Updates a document in the Firestore collection with the given [data].
  ///
  /// The update operation is only supported for equality checks. If the first
  /// where clause is not an equality check, an [Exception] is thrown.
  ///
  /// The [data] parameter is a map of field names to new values. It is modified
  /// by adding an 'updated_at' field with the current timestamp if not present.
  ///
  /// Throws an [AssertionError] if there are no where clauses or the where is not used.
  /// Throws an [Exception] if the first where clause is not an equality check.
  ///
  /// Returns a [Future] that completes when the update is complete.
  Future<void> update(Map<String, dynamic> data) async {
    assert(_whereClauses.isNotEmpty, 'Cannot update without a where clause');

    final clause = _whereClauses.first;

    if (clause['operator'] != '==') {
      throw Exception('Update operation only supports equality checks');
    }

    data['updated_at'] = DateTime.now().toIso8601String();

    await _firestore.collection(this.collectionName).doc(clause['value']).update(data);
  }

  /// Inserts a new document into the Firestore collection with the given [data].
  ///
  /// The [data] parameter is a map of field names to their corresponding values.
  /// If the 'created_at' field is not present in the [data] map, it is added
  /// with the current timestamp. If the 'updated_at' field is not present,
  /// it is also added with the current timestamp.
  ///
  /// Returns a [Future] that completes with the [DocumentReference] of the
  /// newly inserted document.
  Future<DocumentReference> insert(Map<String, dynamic> data) async {
    if (data['created_at'] == null) {
      data['created_at'] = DateTime.now().toIso8601String();
    }

    if (data['updated_at'] == null) {
      data['updated_at'] = DateTime.now().toIso8601String();
    }

    return await _firestore.collection(this.collectionName).add(data);
  }

  /// Deletes a document from the Firestore collection.
  ///
  /// Throws an [Exception] if the delete operation is not supported or if there are no where clauses.
  /// Throws an [Exception] if the first where clause is not an equality check.
  ///
  /// Returns a [Future] that completes when the delete operation is complete.
  Future<void> delete() async {
    if (_whereClauses.isEmpty) {
      throw Exception('Cannot delete without a where clause');
    }

    final clause = _whereClauses.first;
    if (clause['operator'] != '==') {
      throw Exception('Delete operation only supports equality checks');
    }

    await _firestore.collection(this.collectionName).doc(clause['value']).delete();
  }

  QueryBuilder<T> where({required String field, required String operator, required String value}) {
    _whereClauses.add({'field': field, 'operator': operator, 'value': value});
    return this;
  }

  QueryBuilder<T> orderBy(String field, {bool descending = false}) {
    _orderBy = field;
    _descending = descending;
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

  /// Retrieves a list of objects of type [T] from the Firestore collection.
  ///
  /// Returns a [Future] that completes with a list of objects of type [T].
  Future<List<T>> get() async {
    Query query = _firestore.collection(this.collectionName);

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
      query = query.orderBy(_orderBy, descending: _descending);
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
