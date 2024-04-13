import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class LikeButton extends StatelessWidget {
  final void Function() onPressed;
  final String likes;
  final Color? color;
  const LikeButton({super.key, required this.onPressed, required this.likes, this.color,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(Icons.favorite, color: color, size: 35),
          onPressed: onPressed,
        ),
        Text(likes),
      ],
    );
  }
}
