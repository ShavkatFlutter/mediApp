import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../models/video.dart';
import '../utils/constants.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  late VideoPlayerController videoPlayerController;

  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(
      firebaseStore.collection('videos').snapshots().map(
        (QuerySnapshot query) {
          List<Video> retVal = [];
          for (var element in query.docs) {
            retVal.add(
              Video.fromSnap(element),
            );
          }
          return retVal;
        },
      ),
    );
  }
}
