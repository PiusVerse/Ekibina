import 'package:cloud_firestore/cloud_firestore.dart';
import 'sacco_info.dart';

class SaccoInfoDao {
  late String collectionName;
  CollectionReference collection =
      FirebaseFirestore.instance.collection('Sacco Info');

  void saveInfo(SaccoInfo info, saccoName) async {
    await collection.doc(saccoName).set(info.toJson());
    print('after addding to collection');
  }

  void updateInfo(SaccoInfo info, saccoName) async {
    await collection.doc(saccoName).set(info.toJson(), SetOptions(merge: true));
  }

  Stream<QuerySnapshot> getInfoStream() {
    return collection.snapshots();
  }
}
