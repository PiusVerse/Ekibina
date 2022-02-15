import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_info.dart';

class ProfileInfoDao {
  late String collectionName;
  CollectionReference collection =
      FirebaseFirestore.instance.collection('Profile Info');

  void saveInfo(ProfileInfo info, uid) {
    collection.doc(uid).set(info.toJson());
    print('after addding to Profile Info collection');
  }

  Stream<QuerySnapshot> getInfoStream() {
    return collection.snapshots();
  }
}
