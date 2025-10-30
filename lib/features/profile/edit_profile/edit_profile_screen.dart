import 'package:flutter/material.dart';
import 'package:para_job/features/profile/edit_profile/edit_main_info/edit_main_info.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(context.hPct(20)),
          child: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new), // Or your custom icon
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            flexibleSpace: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  context.hBox(8),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.wPct(5),
                      //  vertical: context.hPct(1),
                    ),
                    child: Text(
                      "My Jobs",
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  context.hBox(4),
                ],
              ),
            ),

            bottom: TabBar(
              tabAlignment: TabAlignment.start,
              automaticIndicatorColorAdjustment: true,
              isScrollable: true,
              indicatorColor: AppColors.aquaTeal,
              dividerColor: Colors.transparent,
              labelColor: AppColors.pureWhite, // selected tab text/icon color
              unselectedLabelColor: AppColors.lightGray,
              tabs: [
                Tab(text: "Main info"),
                Tab(text: "Education"),
                Tab(text: "Cv"),
                Tab(text: "Nation ID"),
                Tab(text: "Skills"),
              ],
            ),
          ),
        ),

        body:  TabBarView(
          children: [
            EditMainInfo(),
            Center(child: Text("Job History")),
            Center(child: Text("Saved Jobs")),
            Center(child: Text("Nation ID")),
            Center(child: Text("Skills")),
          ],
        ),
      ),
    );
  }
}
