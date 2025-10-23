/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-15 2:00 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class SearchJobScreen extends StatelessWidget {
  const SearchJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.charcoalBlack,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
        child: Column(
          children: [
            context.hBox(2),
            TextField(
              onTap: () {},
              decoration: InputDecoration(
                hintText: 'Search jobs, companies..',
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.tune),
                ),
                filled: false,
              ),
            ),
          ],
        ),
      ), // empty screen
    );
  }
}
