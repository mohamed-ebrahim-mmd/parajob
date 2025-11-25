import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

import '../../../../../packages/api_client/src/models/responses/check_in_out_history.dart';

class CheckInOutHistoryCard extends StatelessWidget {
  final CheckInOutHistory checkInOutHistory;
  final String workedHours;

  const CheckInOutHistoryCard({
    super.key,
    required this.checkInOutHistory,
    required this.workedHours,
  });

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return DateFormat('EEEE - dd MMM yyyy').format(date);
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '--';
    return DateFormat('hh:mm a').format(time);
  }

  @override
  Widget build(BuildContext context) {
    final date = checkInOutHistory.attendanceDate;
    final checkIn = checkInOutHistory.checkInAt;
    final checkOut = checkInOutHistory.checkOutAt;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(context.wPct(2.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                size: 12,
                color: AppColors.mintTeal,
              ),
              context.wBox(1),
              Text(
                _formatDate(date),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.mintTeal,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Checked in',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.gray8D,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      _formatTime(checkIn),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.pureWhite,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 1,
                height: 40,
                color: AppColors.white15,
                margin: const EdgeInsets.symmetric(horizontal: 12),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Checked out',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.gray8D,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      _formatTime(checkOut),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.pureWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (checkInOutHistory.checkOutAt != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'check_in_out_note'.trParams({'hours': workedHours}),
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.gray8D,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
