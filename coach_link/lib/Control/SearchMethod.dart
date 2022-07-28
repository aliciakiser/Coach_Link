import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_link/Model/User.dart';

class SearchMethod {
  static Future<List<CoachUser>> searchCoach(String keyword) async {
    List<CoachUser> coachList = [];
    QuerySnapshot querySnapshotFirstName = await FirebaseFirestore.instance
        .collection('users')
        .where('firstName', isEqualTo: keyword)
        .get();
    querySnapshotFirstName.docs.forEach((doc) {
      coachList.add(CoachUser(
          firstName: (doc.data() as dynamic)['firstName'],
          lastName: (doc.data() as dynamic)['lastName'],
          email: (doc.data() as dynamic)['email'],
          specialization: (doc.data() as dynamic)['specialization'],
          location: (doc.data() as dynamic)['location'],
          phoneNum: (doc.data() as dynamic)['phoneNum'],
          degree: (doc.data() as dynamic)['degree'],
          degree_HighSchool: (doc.data() as dynamic)['degree_HighSchool'],
          degree_College: (doc.data() as dynamic)['degree_College'],
          workType: (doc.data() as dynamic)['workType'],
          WorkExp: (doc.data() as dynamic)['WorkExp'],
          sport: (doc.data() as dynamic)['sport'],
          AwrdNAchv: (doc.data() as dynamic)['AwrdNAchv']));
    });
    QuerySnapshot querySnapshotLastName = await FirebaseFirestore.instance
        .collection('users')
        .where('lastName', isEqualTo: keyword)
        .get();
    querySnapshotLastName.docs.forEach((doc) {
      if (!ifInclude(coachList, (doc.data() as dynamic)['email'])) {
        coachList.add(CoachUser(
          firstName: (doc.data() as dynamic)['firstName'],
          lastName: (doc.data() as dynamic)['lastName'],
          email: (doc.data() as dynamic)['email'],
          specialization: (doc.data() as dynamic)['specialization'],
          location: (doc.data() as dynamic)['location'],
          phoneNum: (doc.data() as dynamic)['phoneNum'],
          degree: (doc.data() as dynamic)['degree'],
          degree_HighSchool: (doc.data() as dynamic)['degree_HighSchool'],
          degree_College: (doc.data() as dynamic)['degree_College'],
          workType: (doc.data() as dynamic)['workType'],
          WorkExp: (doc.data() as dynamic)['WorkExp'],
          sport: (doc.data() as dynamic)['sport'],
          AwrdNAchv: (doc.data() as dynamic)['AwrdNAchv'],
        ));
      }
    });
    QuerySnapshot querySnapshotSpec = await FirebaseFirestore.instance
        .collection('users')
        .where('specialization', isEqualTo: keyword)
        .get();
    querySnapshotSpec.docs.forEach((doc) {
      if (!ifInclude(coachList, (doc.data() as dynamic)['email'])) {
        coachList.add(CoachUser(
          firstName: (doc.data() as dynamic)['firstName'],
          lastName: (doc.data() as dynamic)['lastName'],
          email: (doc.data() as dynamic)['email'],
          specialization: (doc.data() as dynamic)['specialization'],
          location: (doc.data() as dynamic)['location'],
          phoneNum: (doc.data() as dynamic)['phoneNum'],
          degree: (doc.data() as dynamic)['degree'],
          degree_HighSchool: (doc.data() as dynamic)['degree_HighSchool'],
          degree_College: (doc.data() as dynamic)['degree_College'],
          workType: (doc.data() as dynamic)['workType'],
          WorkExp: (doc.data() as dynamic)['WorkExp'],
          sport: (doc.data() as dynamic)['sport'],
          AwrdNAchv: (doc.data() as dynamic)['AwrdNAchv'],
        ));
      }
    });
    QuerySnapshot querySnapshotLocation = await FirebaseFirestore.instance
        .collection('users')
        .where('location', isEqualTo: keyword)
        .get();
    querySnapshotLocation.docs.forEach((doc) {
      if (!ifInclude(coachList, (doc.data() as dynamic)['email'])) {
        coachList.add(CoachUser(
          firstName: (doc.data() as dynamic)['firstName'],
          lastName: (doc.data() as dynamic)['lastName'],
          email: (doc.data() as dynamic)['email'],
          specialization: (doc.data() as dynamic)['specialization'],
          location: (doc.data() as dynamic)['location'],
          phoneNum: (doc.data() as dynamic)['phoneNum'],
          degree: (doc.data() as dynamic)['degree'],
          degree_HighSchool: (doc.data() as dynamic)['degree_HighSchool'],
          workType: (doc.data() as dynamic)['workType'],
          degree_College: (doc.data() as dynamic)['degree_College'],
          WorkExp: (doc.data() as dynamic)['WorkExp'],
          sport: (doc.data() as dynamic)['sport'],
          AwrdNAchv: (doc.data() as dynamic)['AwrdNAchv'],
        ));
      }
    });
    return coachList;
  }

  static bool ifInclude(List<CoachUser> coachList, String email) {
    for (CoachUser c in coachList) {
      if (c.email == email) {
        return true;
      }
    }
    return false;
  }
}
