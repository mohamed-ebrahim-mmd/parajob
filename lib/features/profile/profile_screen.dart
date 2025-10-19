/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-14 5:57 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/route_manager/controller/routing_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Profile Screen'),
        ElevatedButton(
          onPressed: () {
            Get.find<RoutingController>().logOut();
          },
          child: Text('Log Out'),
        ),
      ],
    );
  }
}
