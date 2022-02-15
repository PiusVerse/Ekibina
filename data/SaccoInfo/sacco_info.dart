import 'package:cloud_firestore/cloud_firestore.dart';

class SaccoInfo {
  String? saccoName;
  String? location;
  int? noOfMembers;
  String? year;
  List? memberNINs;
  List? loanApprovals = [];
  DocumentReference? reference;

  SaccoInfo(
      {this.saccoName,
      this.location,
      this.noOfMembers,
      this.year,
      this.memberNINs,
      this.loanApprovals,
      this.reference});

  factory SaccoInfo.fromJson(Map<dynamic, dynamic> json) {
    return SaccoInfo(
      saccoName: json['saccoName'],
      location: json['location'],
      noOfMembers: json['noOfMembers'],
      year: json['year'],
      memberNINs: json['memberNINs'],
      loanApprovals: json['loanApprovals'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'saccoName': saccoName,
      'location': location,
      'noOfMembers': noOfMembers,
      'year': year,
      'memberNINs': memberNINs,
      'loanApprovals': loanApprovals
    };
  }

  factory SaccoInfo.fromSnapshot(DocumentSnapshot snapshot) {
    final info = SaccoInfo.fromJson(snapshot.data() as Map<String, dynamic>);
    info.reference = snapshot.reference;
    return info;
  }
}
