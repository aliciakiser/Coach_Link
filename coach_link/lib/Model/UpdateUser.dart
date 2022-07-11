import 'package:cloud_firestore/cloud_firestore.dart';
import 'User.dart';
import 'package:coach_link/CoachesDBHelperFunctions_sqlite.dart';

class UpdateUser {
  final String uid;

  UpdateUser({required this.uid});

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future newProfile(String firstName, String lastName, String email,
      {String location = "Ohio, Columbus",
      String phoneNum = "",
      int degree = 0,
      bool workType = true,
      String specialization = ""}) async {
    await CoachesDBHelperFunctions.instance.insertUser(CoachUser(
        uid: uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        location: location,
        phoneNum: phoneNum,
        degree: degree,
        workType: workType,
        specialization: specialization));
    return await _userCollection.doc(uid).set({
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

  Future updateProfile(
      String firstName, String lastName, String email, String specialization,
      {String location = "Ohio, Columbus",
      String phoneNum = "",
      int degree = 0,
      bool workType = true}) async {
    await CoachesDBHelperFunctions.instance.updateUser(CoachUser(
        uid: uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        location: location,
        phoneNum: phoneNum,
        degree: degree,
        workType: workType,
        specialization: specialization));
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

  Future<CoachUser?> getCoach() {
    return _userCollection.doc(uid).get().then((snapshot) {
      return CoachUser(
        uid: uid,
        firstName: (snapshot.data() as dynamic)['firstName'],
        lastName: (snapshot.data() as dynamic)['lastName'],
        email: (snapshot.data() as dynamic)['email'],
        specialization: (snapshot.data() as dynamic)['specialization'],
        location: (snapshot.data() as dynamic)['location'],
        phoneNum: (snapshot.data() as dynamic)['phoneNum'],
        degree: (snapshot.data() as dynamic)['degree'],
        workType: (snapshot.data() as dynamic)['workType'],
      );
    });
  }
}
