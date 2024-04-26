import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dashboard_controller.dart';
import 'default_title_table_widget.dart';
import 'error_dashboard_widget.dart';
import 'loading_dashboard_widget.dart';
import 'title_dashboard_widget.dart';

class CardMultipleWinnersWidget extends StatelessWidget {
  final DashboardController controller;

  const CardMultipleWinnersWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 230),
          child: Obx(() {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: controller.statusWinners.isLoading
                  ? const LoadingDashboardWidget()
                  : controller.statusWinners.isError
                      ? ErrorDashboardWidget(onPressed: controller.getMultipleWinners)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TitleDashboardWidget(title: 'List years with mutiple winners'),
                            const SizedBox(height: 10),
                            DataTable(
                              headingRowHeight: 40,
                              headingRowColor: MaterialStatePropertyAll(Colors.grey.shade200),
                              border: TableBorder.all(
                                  color: Colors.grey.shade400, width: 3, borderRadius: BorderRadius.circular(4)),
                              columns: const [
                                DataColumn(label: DefaultTitleTableWidget(text: 'Year')),
                                DataColumn(label: DefaultTitleTableWidget(text: 'Win Count')),
                              ],
                              rows: controller.multipleWinnersModel!.years
                                  .map(
                                    (e) => DataRow(
                                      cells: [
                                        DataCell(Text(e.year.toString())),
                                        DataCell(Text(e.winnerCount.toString()))
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
            );
          }),
        ),
      ),
    );
  }
}
