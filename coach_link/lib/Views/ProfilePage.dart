import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coach_link/Model/UpdateUser.dart';
import 'package:coach_link/Model/User.dart';
import 'package:coach_link/Model/UpdateUser.dart';

class ProfilePage extends StatefulWidget {
  String uid = "";
  ProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState(uid: uid);
}

class _ProfilePageState extends State<ProfilePage> {
  String uid = " ";
  CoachUser? _coachUser;
  UpdateUser? _userProfile;

  _ProfilePageState({required this.uid});

  Future<void> _GetUserState() async {
    print(uid);
    _userProfile = UpdateUser(uid: uid);
    _coachUser = await _userProfile?.getCoach();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _GetUserState();
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            _getBannerWithAvatar(context),
            _getPersonalProfile(),
          ],
        ),
      ],
    );
    // body: Column(
    //   children: [
    //     SizedBox(
    //       height: MediaQuery.of(context).size.height / 4,
    //       child: Stack(
    //         children: [
    //           Container(
    //             decoration: BoxDecoration(
    //               image: DecorationImage(
    //                 image: AssetImage("assets/banner.jpeg"),
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     Column(mainAxisAlignment: Alignment.topLeft, children: [
    //       CircleAvatar(radius: 50, child: Text(_coachUser?.firstName ?? "")),
    //       Text(
    //         _coachUser?.firstName ?? "" + " " + (_coachUser?.lastName ?? ""),
    //         textAlign: TextAlign.left,
    //       ),
    //       Text(
    //         "Email: " + (_coachUser?.email ?? ""),
    //         textAlign: TextAlign.left,
    //       ),
    //       Text(
    //         "Phone: " + (_coachUser?.phoneNum ?? ""),
    //         textAlign: TextAlign.left,
    //       ),
    //       Text(
    //         "Address: " + (_coachUser?.location ?? ""),
    //         textAlign: TextAlign.left,
    //       ),
    //       Text(
    //         "Specialization: " + (_coachUser?.specialization ?? ""),
    //         textAlign: TextAlign.left,
    //       ),
    //     ]),
    //   ],
    // ),
  }

  Widget _getBannerWithAvatar(BuildContext context) {
    const double bannerHeight = 230;
    const double imageHeight = 180;
    const double avatarRadius = 45;
    const double avatarBorderSize = 4;
    return SliverToBoxAdapter(
      child: Container(
        height: bannerHeight,
        color: Colors.white70,
        alignment: Alignment.topLeft,
        child: Stack(
          children: [
            Container(
              height: bannerHeight,
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/banner.jpeg",
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 20,
              top: imageHeight - avatarRadius - avatarBorderSize,
              child: CircleAvatar(
                  radius: 50, child: Text(_coachUser?.firstName ?? "")),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPersonalProfile() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        color: Colors.white70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  _coachUser?.firstName ??
                      "" + " " + (_coachUser?.lastName ?? ""),
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            SizedBox(height: 2),
            Text(
              "Email: " + (_coachUser?.email ?? ""),
              style: TextStyle(fontSize: 15.0, color: Colors.grey[700]),
            ),
            SizedBox(height: 2),
            Text(
              "Address: " + (_coachUser?.location ?? ""),
              style: TextStyle(fontSize: 15.0, color: Colors.grey[700]),
            ),
            SizedBox(height: 2),
            Text(
              "Specialization: " + (_coachUser?.specialization ?? ""),
              style: TextStyle(fontSize: 15.0, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            // Text(
            //   personalProfile.description,
            //   style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
            // ),
          ],
        ),
      ),
    );
  }
}
