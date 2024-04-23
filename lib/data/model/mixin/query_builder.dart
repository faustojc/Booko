import 'package:cloud_firestore/cloud_firestore.dart';

mixin QueryBuilder<T> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Map<String, dynamic>> _whereClauses = [];

  String _orderBy = '';
  bool _descending = false;
  int _limit = 0;

  DocumentSnapshot<Map<String, dynamic>>? _startAfterDocument;
  Iterable<Object> _startAt = [];
  Iterable<Object> _endAt = [];
  Iterable<Object> _startAfter = [];
  Iterable<Object> _endBefore = [];

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
  Future<DocumentReference<Map<String, dynamic>>> insert(Map<String, dynamic> data) async {
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

  QueryBuilder<T> where(
    String field, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    Iterable<Object>? arrayContainsAny,
    Iterable<Object>? whereIn,
    Iterable<Object>? whereNotIn,
  }) {
    _whereClauses.add({
      'field': field,
      'isEqualTo': isEqualTo,
      'isNotEqualTo': isNotEqualTo,
      'isLessThan': isLessThan,
      'isLessThanOrEqualTo': isLessThanOrEqualTo,
      'isGreaterThan': isGreaterThan,
      'isGreaterThanOrEqualTo': isGreaterThanOrEqualTo,
      'arrayContains': arrayContains,
      'arrayContainsAny': arrayContainsAny,
      'whereIn': whereIn,
      'whereNotIn': whereNotIn,
    });
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

  QueryBuilder<T> startAt(Iterable<Object> value) {
    _startAt = value;
    return this;
  }

  QueryBuilder<T> endAt(Iterable<Object> value) {
    _endAt = value;
    return this;
  }

  QueryBuilder<T> startAfter(Iterable<Object> value) {
    _startAfter = value;
    return this;
  }

  QueryBuilder<T> startAfterDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    _startAfterDocument = document;
    return this;
  }

  QueryBuilder<T> endBefore(Iterable<Object> value) {
    _endBefore = value;
    return this;
  }

  /// Retrieves a list of objects of type [T] from the Firestore collection.
  ///
  /// Returns a [Future] that completes with a list of objects of type [T].
  Future<List<T>> get() async {
    Query query = _firestore.collection(this.collectionName);

    if (_whereClauses.isNotEmpty) {
      for (Map<String, dynamic> clause in _whereClauses) {
        query = query.where(
          clause['field'],
          isEqualTo: clause['isEqualTo'],
          isNotEqualTo: clause['isNotEqualTo'],
          isLessThan: clause['isLessThan'],
          isLessThanOrEqualTo: clause['isLessThanOrEqualTo'],
          isGreaterThan: clause['isGreaterThan'],
          isGreaterThanOrEqualTo: clause['isGreaterThanOrEqualTo'],
          arrayContains: clause['arrayContains'],
          arrayContainsAny: clause['arrayContainsAny'],
          whereIn: clause['whereIn'],
          whereNotIn: clause['whereNotIn'],
        );
      }
    }

    if (_orderBy.isNotEmpty) {
      query = query.orderBy(_orderBy, descending: _descending);
    }

    if (_limit > 0) {
      query = query.limit(_limit);
    }

    if (_startAt.isNotEmpty) {
      query = query.startAt(_startAt);
    }

    if (_endAt.isNotEmpty) {
      query = query.endAt(_endAt);
    }

    if (_startAfter.isNotEmpty) {
      query = query.startAfter(_startAfter);
    }

    if (_endBefore.isNotEmpty) {
      query = query.endBefore(_endBefore);
    }

    if (_startAfterDocument != null) {
      query = query.startAfterDocument(_startAfterDocument!);
    }

    final snapshots = await query.get();
    return snapshots.docs.map((doc) => fromJson(doc.data() as Map<String, dynamic>)).toList();
  }
}
