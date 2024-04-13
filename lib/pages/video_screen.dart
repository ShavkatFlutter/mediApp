import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:get/get.dart';
import 'package:media_app/controllers/video_controller.dart';
import 'package:media_app/pages/comment_page.dart';
import 'package:media_app/utils/buttons/like_button.dart';
import '../auth/auth.dart';
import '../utils/constants.dart';
import '../utils/video_player_item.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final VideoController videoController = Get.put(VideoController());

  likeVideo(String id) async {
    try {
      var email = authController.user.email;
      DocumentSnapshot doc =
          await firebaseStore.collection("videos").doc(id).get();

      if ((doc.data() as dynamic)?["likes"]?.contains(email) ?? false) {
        await firebaseStore.collection("videos").doc(id).update({
          "likes": FieldValue.arrayRemove([email]),
        });
      } else {
        await firebaseStore.collection("videos").doc(id).update({
          "likes": FieldValue.arrayUnion([email]),
        });
      }
    } catch (e) {
      print("Error liking/unliking video: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          itemCount: videoController.videoList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final data = videoController.videoList[index];
            return Stack(
              children: [
                VideoPlayerItem(videoUrl: data.videoUrl),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              radius: 15,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ExpandableText(
                                trim: 1,
                                linkTextStyle: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.left,
                                data.username, // Assuming there's a title field in your video data
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            OutlinedButton(
                                onPressed: () {}, child: const Text("Follw")),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.play_arrow),
                            ),
                            Expanded(
                              child: ExpandableText(
                                trim: 1,
                                readMoreText: "more",
                                readLessText: "close",
                                linkTextStyle: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.left,
                                data.caption ??
                                    '', // Assuming there's a title field in your video data
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: size.height / 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Column(
                                  children: [
                                    LikeButton(
                                      onPressed: () => likeVideo(data.id),
                                      likes: data.likes.length.toString(),
                                      color: data.likes.contains(authController.user.email) ? Colors.red : Colors.white,
                                    ),
                                    const SizedBox(height: 20),
                                    Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (contex) =>
                                                        CommentScreen(id: data.id,)),
                                              );
                                            },
                                            icon: const Icon(Icons.comment,
                                                size: 35)),
                                        const Text("10"),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    const Column(
                                      children: [
                                        Icon(Icons.share, size: 35),
                                        Text("5"),
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
