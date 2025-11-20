// Karim Toson || kareemtoson1@gmail.com || 19/11/2025 2:06 PM
import 'package:flutter/material.dart';
import 'package:para_job/features/my_notifications/strike/widgets/strike_card.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class NotificationStrikeScreen extends StatelessWidget {
  const NotificationStrikeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop(); // Handle back action
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "warning",

                  style: TextStyle(
                    color: AppColors.rejected,
                    fontSize: context.wPct(7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                context.hBox(1),

                Text(
                  "Violation of the application rules",
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: context.wPct(5),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                context.hBox(1),
                SizedBox(
                  height: context.hPct(8),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: AppColors.rejected,
                        size: context.wPct(10),
                      ),
                      Icon(
                        Icons.warning_amber_rounded,
                        color: AppColors.rejected,
                        size: context.wPct(10),
                      ),
                      Icon(
                        Icons.warning_amber_rounded,
                        color: AppColors.grayButton,
                        size: context.wPct(10),
                      ),
                    ],
                  ),
                ),

                Text(
                  "2 out of 3 violations",
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: context.wPct(4),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                context.hBox(2),

                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [MyStrikeCard(), context.hBox(4), MyStrikeCard()],
                ),
                context.hBox(2),

                //Why you don’t want to get a warning?
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Why you don’t want to get a warning?",
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: context.wPct(5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Warnings can limit your access and features.\n Follow the rules to keep your account safe and fully active.",
                    style: TextStyle(
                      color: AppColors.softWhite80,
                      fontSize: context.wPct(4),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                context.hBox(3),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "How to avoid getting a warning?",
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: context.wPct(5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Follow the app rules carefully: provide accurate information.\nrespect other users, and avoid prohibited actions.\n Staying compliant keeps your account safe and fully functional.",
                    style: TextStyle(
                      color: AppColors.softWhite80,
                      fontSize: context.wPct(4),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                context.hBox(2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
