import 'dart:async';
import 'package:coach_link/COachUser_sqlite.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CoachesDBHelperFunctions {
  static final _databaseName = "CoachUsers.db";
  static final _databaseVersion = 1;
  static final table = 'Users_table';
  static final firstName = 'firstName';
  static final lastName = 'lastName';
  static final email = 'email';
  static final specialization = 'specialization';
  static final location = 'location';
  static final phoneNum = 'phoneNum';
  static final degree = 'degree';
  static final workType = 'workType';

  // make this a singleton class
  CoachesDBHelperFunctions._privateConstructor();
  static final CoachesDBHelperFunctions instance =
      CoachesDBHelperFunctions._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // Run the CREATE TABLE statement on the database.
    await db.execute(
      'CREATE TABLE  USERS (UserID VARCHAR(10) NOT NULL, UserName VARCHAR(20) NOT NULL DEFAULT " ",EmailAddress VARCHAR(20) NOT NULL,Password VARCHAR(20) NOT NULL,PhoneNumber VARCHAR(10) NOT NULL,Location VARCHAR(50),Achievements ARRAY(99),Degree VARCHAR(10) NOT NULL,WorkType BOOLEAN DEFAULT 0,Field VARCHAR(10) NOT NULL,Specialty VARCHAR(10) NOT NULL,PRIMARY KEY(UserID))',
    );
  }

// Define a function that inserts user into the database
  Future<void> insertUser(CoachUser user) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the user into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same user is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// A method that retrieves all the users from the users table.
  Future<List<CoachUser>> users() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Users.
    final List<Map<String, dynamic>> maps = await db.query('users');

    // Convert the List<Map<String, dynamic> into a List<CoachUsers>.
    return List.generate(maps.length, (i) {
      return CoachUser(
        email: maps[i]['email'],
        firstName: maps[i]['firstName'],
        lastName: maps[i]['lastName'],
        specialization: maps[i]['specialization'],
        location: maps[i]['location'],
        phoneNum: maps[i]['phoneNum'],
        degree: maps[i]['degree'],
        workType: maps[i]['workType'],
      );
    });
  }

  Future<void> updateUser(CoachUser user) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given user.
    await db.update(
      'user',
      user.toMap(),
      // Ensure that the user has a matching id.
      where: 'email = ?',
      // Pass the user's id as a whereArg to prevent SQL injection.
      whereArgs: [user.email],
    );
  }

  Future<void> deleteUser(String email) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the user from the database.
    await db.delete(
      'users',
      // Use a `where` clause to delete a specific user.
      where: 'email = ?',
      // Pass the user's email as a whereArg to prevent SQL injection.
      whereArgs: [email],
    );
  }
}
