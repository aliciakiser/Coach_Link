import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_link/Model/Post.dart';
import 'package:uuid/uuid.dart';

class NewPostControl {
  final String uid;
  var uuid = Uuid();

  NewPostControl({required this.uid});

  final CollectionReference _postCollection =
      FirebaseFirestore.instance.collection('posts');

  Future newPost(String title, String content) async {
    return await _postCollection.doc(uuid.v1()).set({
      'uid': uid,
      'title': title,
      'content': content,
    });
  }
}
