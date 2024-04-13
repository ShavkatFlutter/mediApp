
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController _videoPlayerController;

  VideoPlayerController get videoPlayerController => _videoPlayerController;

  VideoController() {
    _videoPlayerController = VideoPlayerController.network(
        'https://www.example.com/sample_video.mp4');
    _videoPlayerController.initialize().then((_) {
      _videoPlayerController.setLooping(true);
      update(); // Trigger UI update after initialization
    });
  }

  @override
  void onClose() {
    _videoPlayerController.dispose();
    super.onClose();
  }
}

// import 'package:flutter/material.dart';
// import 'package:media_app/pages/login_page.dart';
// import 'package:media_app/pages/register_page.dart';
//
// class LoginOrRegister extends StatefulWidget {
//   const LoginOrRegister({super.key});
//
//   @override
//   State<LoginOrRegister> createState() => _LoginOrRegisterState();
// }
//
// class _LoginOrRegisterState extends State<LoginOrRegister> {
//
//   bool showLoginPage = true;
//
//   void togglePages(){
//     setState(() {
//       showLoginPage = !showLoginPage;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if(showLoginPage){
//       return LoginPage(onTap: togglePages);
//     } else {
//       return RegisterPage(onTap: togglePages);
//     }
//   }
// }
