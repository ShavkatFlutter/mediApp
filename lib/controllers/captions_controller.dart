import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:media_app/utils/constants.dart';
import '../models/video.dart';

class UploadVideoController extends GetxController {
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    String fileName = '$id.mp4'; // Include file extension in the file name
    Reference ref = firebaseStorage.ref().child('videos').child(fileName);
    UploadTask uploadTask = ref.putFile(
      File(videoPath),
      SettableMetadata(contentType: 'video/mp4'), // Specify content type as video/mp4
    );
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // Upload video
  uploadVideo(String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
      await firebaseStore.collection('users').doc(uid).get();
      // get id
      var allDocs = await firebaseStore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage("Video$len", videoPath);

      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>)['name'],
        uid: uid,
        id: "Video$len",
        likes: [],
        commentCount: 0,
        shareCount: 0,
        caption: caption,
        videoUrl: videoUrl,
      );

      await firebaseStore.collection('videos').doc('Video$len').set(
        video.toJson(),
      );

      showProgressBar = false;
      update();

      Get.back();

      Get.snackbar('Successfully uploaded Video', "Success, you uploaded video");
    } catch (e) {
      Get.snackbar('Error Uploading Video', e.toString());
    }
  }
  void signOut() async {
    await firebaseAuth.signOut();
  }
}
