import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meal_mate/screens/tab_box/profile/user_posts/tab_bar_user_posts.dart';

import 'package:meal_mate/utils/tools/file_importer.dart';

import '../../../add_screen/view_model/main_view_model.dart';
import '../../../edit/edit_screen.dart';

class UsersPost extends StatefulWidget {
  const UsersPost({super.key});

  @override
  State<UsersPost> createState() => _UsersPostState();
}

class _UsersPostState extends State<UsersPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Your Posts & Favorite",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorColor: AppColors.primary,
              labelColor: AppColors.primary,
              // unselectedLabelColor: AppColors.borderShade600,
              tabs: [
                Tab(
                  child: Text("Posts"),
                ),
                Tab(
                  child: Text("Favorite"),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  TabBarUserPosts(),
                  Column(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
