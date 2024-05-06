import 'package:cloud_firestore/cloud_firestore.dart';

/// The `QueryBuilder<T>` mixin class is a powerful utility for building and executing
/// queries against a Firestore collection, providing an easy-to-use and flexible
/// interface for constructing complex queries with various filtering, ordering,
/// and pagination options.
///
/// This mixin is designed to be included in model classes that represent entities
/// stored in a Firestore collection. By implementing the `fromJson` method and
/// providing the `collectionName` getter, the `QueryBuilder` can seamlessly map
/// retrieved documents to instances of the inheriting class.
///
/// The `QueryBuilder` leverages the Firebase Firestore SDK to interact with Firestore
/// collections, allowing you to perform various operations such as querying, inserting,
/// updating, and deleting documents.
///
/// To use the `QueryBuilder`, you need to create a class that represents your model
/// or entity, include the `QueryBuilder<T>` mixin, and implement the required
/// `fromJson` method and `collectionName` getter. Once you have your model class set up,
/// you can use the provided methods to construct and execute queries, as well as
/// perform CRUD operations on the Firestore collection.
///
/// Example usage:
///
/// ```dart
/// class Customer with QueryBuilder<Customer> {
///   final String id;
///   final String name;
///   final String email;
///
///   Customer({
///     required this.id,
///     required this.name,
///     required this.email,
///   });
///
///   @override
///   Customer fromJson(Map<String, dynamic> json) {
///     return Customer(
///       id: json['id'],
///       name: json['name'],
///       email: json['email'],
///     );
///   }
///
///   @override
///   String get collectionName => 'customers';
/// }
///
/// // Querying customers
/// Future<List<Customer>> getCustomers() async {
///   return await Customer().where('isActive', isEqualTo: true).get();
/// }
///
/// // Inserting a new customer
/// Future<void> addCustomer(String name, String email) async {
///   await Customer().insert({
///     'name': name,
///     'email': email,
///     'isActive': true,
///   });
/// }
/// ```
///
/// In the example above, the `Customer` class includes the `QueryBuilder` mixin and
/// implements the required methods. The `getCustomers` function queries the Firestore
/// collection for active customers, while the `addCustomer` function inserts a new
/// customer document into the collection.
mixin QueryBuilder<T> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Map<String, dynamic>> _whereClauses = [];

  WriteBatch? _batch;
  DocumentReference<Map<String, dynamic>>? _reference;

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

    if (clause['isEqualTo'] == null) {
      throw Exception('Update operation only supports equality checks');
    }

    data['updated_at'] = Timestamp.now();

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
    data['created_at'] = Timestamp.now();
    data['updated_at'] = Timestamp.now();

    return await _firestore.collection(this.collectionName).add(data);
  }

  /// Deletes a document from the Firestore collection.
  ///
  /// Throws an [Exception] if the delete operation is not supported or if there are no where clauses.
  /// Throws an [Exception] if the first where clause is not an equality check.
  ///
  /// Returns a [Future] that completes when the delete operation is complete.
  Future<void> delete() async {
    assert(_whereClauses.isNotEmpty, 'Cannot delete without a where clause');

    final clause = _whereClauses.first;
    if (clause['isEqualTo'] == null) {
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

  QueryBuilder<T> startBatch() {
    _batch = _firestore.batch();

    return this;
  }

  QueryBuilder<T> batchSet(Map<String, dynamic> data) {
    assert(_batch != null, 'Cannot batch set without starting a batch operation first');

    _reference = _firestore.collection(this.collectionName).doc(data['id']);
    _batch!.set(_reference!, data);

    return this;
  }

  QueryBuilder<T> batchDelete(String id) {
    assert(_batch != null, 'Cannot batch delete without starting a batch operation first');

    _reference = _firestore.collection(this.collectionName).doc(id);
    _batch!.delete(_reference!);

    return this;
  }

  Future<void> endBatch() async {
    assert(_batch != null, 'Cannot end batch without a batch operation first');
    assert(_reference != null, 'Cannot end batch without set or delete a reference first');

    await _batch!.commit();

    _batch = null;
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

    return snapshots.docs.map((doc) {
      final Map<String, dynamic> data = {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      };

      return fromJson(data);
    }).toList();
  }
}
