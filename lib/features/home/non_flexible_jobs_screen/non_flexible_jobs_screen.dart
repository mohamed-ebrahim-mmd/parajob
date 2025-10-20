import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class NonFlexibleJobsScreen extends StatelessWidget {
  const NonFlexibleJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Row
            Text(
              "Non-Flexible Jobs",
              style: TextStyle(
                fontSize: context.wPct(4.5),
                fontWeight: FontWeight.bold,
              ),
            ),
            context.hBox(2),

            // Vertical List of Job Cards

            // ListView.separated(
            //   scrollDirection: Axis.vertical,
            //   shrinkWrap: true,
            //   primary: false,
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemCount: jobs.length,
            //   separatorBuilder: (_, __) => context.hBox(3),
            //   itemBuilder: (context, index) {
            //     return JobCard(job: jobs[index]);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

//List<Job> jobs=[Job(title: "job1"),Job(title: "job2")];
