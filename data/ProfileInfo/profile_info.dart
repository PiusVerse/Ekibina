import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileInfo {
  final String nin;
  final String fullName;
  String userId;
  DocumentReference? reference;

  ProfileInfo(
      {required this.nin,
      required this.fullName,
      required this.userId,
      this.reference});

  factory ProfileInfo.fromJson(Map<dynamic, dynamic> json) {
    return ProfileInfo(
        nin: json['nin'], fullName: json['fullName'], userId: json['userId']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fullName': fullName,
      'nin': nin,
      'UserId': userId
    };
  }

  factory ProfileInfo.fromSnapshot(DocumentSnapshot snapshot) {
    final info = ProfileInfo.fromJson(snapshot.data() as Map<String, dynamic>);
    info.reference = snapshot.reference;
    return info;
  }
}
