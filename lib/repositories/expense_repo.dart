import 'package:expens_tracker/export/export.dart';



class ExpenseRepository {
  ExpenseRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;


  Stream<List<Expense>> watchExpenses() {
    return _auth.authStateChanges().asyncExpand((user) {
      if (user == null) return Stream.value(const <Expense>[]);

      return _firestore
          .collection('users')
          .doc(user.uid)
          .collection('expenses')
          .orderBy('date', descending: true)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Expense.fromMap(doc.id, doc.data())).toList());
    });
  }

  Future<void> addExpense(Expense expense) async {
    final uid = _requireUid();
    await _firestore.collection('users').doc(uid).collection('expenses').add(expense.toMap());
  }

  Future<void> updateExpense(Expense expense) async {
    final uid = _requireUid();
    await _firestore.collection('users').doc(uid).collection('expenses').doc(expense.id).update(expense.toMap());
  }

  Future<void> deleteExpense(String id) async {
    final uid = _requireUid();
    await _firestore.collection('users').doc(uid).collection('expenses').doc(id).delete();
  }

  String _requireUid() {
    final user = _auth.currentUser;
    if (user == null) throw StateError('No authenticated user.');
    return user.uid;
  }
}