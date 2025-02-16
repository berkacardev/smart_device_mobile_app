import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PackageInitializer{
  static final FirebaseFirestore firebaseFirestoreInstance = FirebaseFirestore.instance;
}