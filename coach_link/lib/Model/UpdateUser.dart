import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateUser {
  final String uid;

  UpdateUser({required this.uid});

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateProfile(
      String firstName, String lastName, String email, String specialization,
      {String location = "Ohio, Columbus",
      String phoneNum = "",
      int degree = 0,
      bool workType = true}) async {
    return await _userCollection.doc(uid).update({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'specialization': specialization,
      'location': location,
      'phoneNum': phoneNum,
      'degree': degree,
      'workType': workType,
    });
  }
}
