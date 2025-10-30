import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/features/my_notifications/my_notification_utils.dart';
import 'package:para_job/features/my_notifications/widgets/my_notification_card.dart';

import '../../../packages/themeing/app_colors.dart';
import '../../../packages/themeing/media_query_values.dart';
import '../../packages/api_client/src/models/responses/my_notification.dart';

class MyNotificationScreen extends StatefulWidget {
  const MyNotificationScreen({super.key});

  @override
  State<MyNotificationScreen> createState() => _MyNotificationScreenState();
}

class _MyNotificationScreenState extends State<MyNotificationScreen> {
  late final PagingController<int, MyNotification> pagingController;

  @override
  void initState() {
    super.initState();
    pagingController = initPagingController();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoalBlack,
      body: SafeArea(
        child: Column(
          children: [
            context.hBox(2),
            Expanded(
              child: PagingListener(
                controller: pagingController,
                builder: (context, state, fetchNextPage) {
                  return PagedListView<int, MyNotification>(
                    state: state,
                    fetchNextPage: fetchNextPage,
                    builderDelegate: PagedChildBuilderDelegate<MyNotification>(
                      noItemsFoundIndicatorBuilder: (_) => Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: context.hPct(20)),
                          child: Text(
                            "No notifications found",
                            style: TextStyle(
                              color: AppColors.white50,
                              fontSize: context.wPct(4),
                            ),
                          ),
                        ),
                      ),

                      itemBuilder: (context, item, index) {
                        final allItems =
                            state.pages?.expand((e) => e).toList() ?? [];
                        final now = DateTime.now();

                        List<Widget> children = [];

                        final date = DateTime.tryParse(item.createdAt);
                        if (date == null) return const SizedBox.shrink();

                        String sectionLabel = getSectionLabel(date, now);

                        if (index == 0) {
                          children.add(
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.wPct(5),
                                vertical: context.wPct(2),
                              ),

                              child: Text(
                                sectionLabel,
                                style: TextStyle(
                                  fontSize: context.wPct(4.2),
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white50,
                                ),
                              ),
                            ),
                          );
                        } else {
                          final prevDate = DateTime.tryParse(
                            allItems[index - 1].createdAt,
                          );
                          if (prevDate != null) {
                            final prevLabel = getSectionLabel(prevDate, now);
                            if (prevLabel != sectionLabel) {
                              children.add(
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: context.wPct(5),
                                    vertical: context.wPct(2),
                                  ),

                                  child: Text(
                                    sectionLabel,
                                    style: TextStyle(
                                      fontSize: context.wPct(4.2),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.white50,
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                        }

                        children.add(MyNotificationCard(myNotification: item));
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: children,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
