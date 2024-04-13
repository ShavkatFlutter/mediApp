import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_app/helper_widgets/text_field.dart';
import 'package:media_app/pages/profile_page.dart';

import '../models/user.dart';
import '../utils/constants.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: InputText(
            hintText: "Search",
            label: const Text(""),
            onSubmitted: (value) => searchController.searchUser(value),
            obscureText: false,
          ),
        ),
        body: searchController.searchUsers.isEmpty
            ? const Center(
                child: Text("Search Users"),
              )
            : ListView.builder(
                itemCount: searchController.searchUsers.length,
                itemBuilder: (context, index) {
                  User user = searchController.searchUsers[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(uid: user.uid),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: const CircleAvatar(
                          backgroundColor: Colors.blue, radius: 17),
                      title: Text(user.name),
                    ),
                  );
                },
              ),
      );
    });
  }
}

class SearchController extends GetxController {
  final Rx<List<User>> _searchUsers = Rx<List<User>>([]);

  List<User> get searchUsers => _searchUsers.value;

  searchUser(String typeUser) async {
    _searchUsers.bindStream(firebaseStore
        .collection("users")
        .where("name", isGreaterThanOrEqualTo: typeUser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<User> retval = [];
      for (var element in query.docs) {
        retval.add(User.fromSnap(element));
      }
      return retval;
    }));
  }
}
