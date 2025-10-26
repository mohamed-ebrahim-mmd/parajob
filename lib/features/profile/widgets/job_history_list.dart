// import 'package:flutter/material.dart';

// import 'package:para_job/packages/api_client/src/models/models.dart';

// import 'package:para_job/packages/themeing/media_query_values.dart';
// import 'package:para_job/packages/ui_components/job_card.dart';

// class JobHistoryList extends StatelessWidget {
//   final List<Job> jobHistory;
//   final VoidCallback? onSeeAll;
//   final String? title;

//   const JobHistoryList({
//     super.key,
//     required this.jobHistory,
//     this.onSeeAll,
//     this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,

//       children: [
//         // Header Row
//         Text(
//           title ?? "Your job history",
//           style: TextStyle(
//             fontSize: context.wPct(4.5),
//             fontWeight: FontWeight.bold,
//           ),
//         ),

//         // Vertical List of Job Cards
//         ListView.separated(
//           scrollDirection: Axis.vertical,
//           shrinkWrap: true,
//           primary: false,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: jobHistory.length,
//           separatorBuilder: (_, __) => context.hBox(2),
//           itemBuilder: (context, index) {
//             final job = jobHistory[index];
//             return JobCard(job: job);

//           },
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:para_job/packages/api_client/src/models/models.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/job_card.dart';

class JobHistoryList extends StatefulWidget {
  final List<Job> jobHistory;
  final String? title;

  const JobHistoryList({super.key, required this.jobHistory, this.title});

  @override
  State<JobHistoryList> createState() => _JobHistoryListState();
}

class _JobHistoryListState extends State<JobHistoryList> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    // Determine how many items to show
    final visibleJobs = _showAll
        ? widget.jobHistory
        : widget.jobHistory.take(2).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Text(
          widget.title ?? "Your job history",
          style: TextStyle(
            fontSize: context.wPct(4.5),
            fontWeight: FontWeight.bold,
          ),
        ),

        //  context.hBox(1),

        // Job List
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: visibleJobs.length,
          separatorBuilder: (_, __) => context.hBox(2),
          itemBuilder: (context, index) {
            final job = visibleJobs[index];
            return JobCard(job: job);
          },
        ),

        // "View All" button
        if (widget.jobHistory.length > 2)
          Align(
            alignment: AlignmentGeometry.center,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _showAll = !_showAll;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _showAll ? "View Less" : "View more",
                    style: TextStyle(
                      fontSize: context.wPct(3.9),
                      fontWeight: FontWeight.w500,
                      color: AppColors.pureWhite,
                    ),
                  ),
                      
                  Icon(
                     Icons.fast_forward_rounded,
                    color: AppColors.pureWhite,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
