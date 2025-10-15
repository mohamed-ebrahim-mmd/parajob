/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-14 5:57 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class HomeScreen extends StatelessWidget {
  final user = Get.find<UserController>().user;
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.hBox(2),
              Text(
                'Welcome, ${user?.name ?? "Guest"}',
                style: TextStyle(
                  fontSize: context.wPct(4),
                  color: const Color(0xFFCCCCCC),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Discover jobs',
                style: TextStyle(
                  fontSize: context.wPct(7),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(2),
            ],
          ),
        ),
      ),
    );
  }
}
