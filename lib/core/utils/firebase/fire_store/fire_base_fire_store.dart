import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
@injectable
class FireStoreService {
  static final FireStoreService _instance = FireStoreService._internal();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseFirestore _firebaseDatabase = FirebaseFirestore.instance;
  factory FireStoreService() {
    return _instance;
  }

  FireStoreService._internal();
  FirebaseFirestore get fireStore => _fireStore;
  FirebaseFirestore get firebaseDatabase => _firebaseDatabase;
}