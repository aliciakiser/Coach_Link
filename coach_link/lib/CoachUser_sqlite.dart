import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CoachUser {
  final String firstName;
  final String lastName;
  final String email;
  final String specialization;
  final String location;
  final String phoneNum;
  final int degree;
  final bool workType;

  const CoachUser({
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
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'specialization': specialization,
      'location': location,
      'phoneNum': phoneNum,
      'degree': degree,
      'workType': workType,
    };
  }

  // Implement toString to make it easier to see information about
  // each user when using the print statement.
  @override
  String toString() {
    return 'firstName: $firstName,lastName:$lastName,email:$email';
  }
}
