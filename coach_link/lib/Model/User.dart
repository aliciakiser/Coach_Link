class CoachUser {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String specialization;
  final String location;
  final String phoneNum;
  final int degree;
  final bool workType;

  CoachUser({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.specialization,
    required this.location,
    required this.phoneNum,
    required this.degree,
    required this.workType,
  });
  // Convert a User into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'UserID': uid,
      'FirstName': firstName,
      'LastName': lastName,
      'EmailAddress': email,
      'Field': specialization,
      'Location': location,
      'PhoneNumber': phoneNum,
      'Degree': degree,
      'WorkType': workType == true ? 1 : 0,
    };
  }

  // Implement toString to make it easier to see information about
  // each user when using the print statement.
  @override
  String toString() {
    return 'firstName: $firstName,lastName:$lastName,email:$email';
  }
}
