import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texo_it_films/modules/dashboard/dashboard_controller.dart';

import 'default_title_table_widget.dart';
import 'error_dashboard_widget.dart';
import 'loading_dashboard_widget.dart';
import 'title_dashboard_widget.dart';

class CardMinMaxProducersWidget extends StatelessWidget {
  final DashboardController controller;

  const CardMinMaxProducersWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 320),
          child: Obx(() {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: controller.statusMinMaxProducers.isLoading
                  ? const LoadingDashboardWidget()
                  : controller.statusMinMaxProducers.isError
                      ? ErrorDashboardWidget(onPressed: controller.getMinMaxProducers)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TitleDashboardWidget(
                                title: 'Producers with longest and shortest interval between wins'),
                            const SizedBox(height: 10),
                            Text(
                              'Maximum',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            if (controller.minMaxProducersModel != null) ...[
                              const SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  headingRowHeight: 40,
                                  headingRowColor: MaterialStatePropertyAll(Colors.grey.shade200),
                                  border: TableBorder.all(
                                      color: Colors.grey.shade400, width: 3, borderRadius: BorderRadius.circular(4)),
                                  columns: const [
                                    DataColumn(label: DefaultTitleTableWidget(text: 'Producers')),
                                    DataColumn(label: DefaultTitleTableWidget(text: 'Interval')),
                                    DataColumn(label: DefaultTitleTableWidget(text: 'Previous Year')),
                                    DataColumn(label: DefaultTitleTableWidget(text: 'Following Year')),
                                  ],
                                  rows: controller.minMaxProducersModel!.max
                                      .map(
                                        (e) => DataRow(
                                          cells: [
                                            DataCell(Text(e.producer)),
                                            DataCell(Text(e.interval.toString())),
                                            DataCell(Text(e.previousWin.toString())),
                                            DataCell(Text(e.followingWin.toString()))
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Minimum',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  headingRowHeight: 40,
                                  headingRowColor: MaterialStatePropertyAll(Colors.grey.shade200),
                                  border: TableBorder.all(
                                      color: Colors.grey.shade400, width: 3, borderRadius: BorderRadius.circular(4)),
                                  columns: const [
                                    DataColumn(label: DefaultTitleTableWidget(text: 'Producers')),
                                    DataColumn(label: DefaultTitleTableWidget(text: 'Interval')),
                                    DataColumn(label: DefaultTitleTableWidget(text: 'Previous Year')),
                                    DataColumn(label: DefaultTitleTableWidget(text: 'Following Year')),
                                  ],
                                  rows: controller.minMaxProducersModel!.min
                                      .map(
                                        (e) => DataRow(
                                          cells: [
                                            DataCell(Text(e.producer)),
                                            DataCell(Text(e.interval.toString())),
                                            DataCell(Text(e.previousWin.toString())),
                                            DataCell(Text(e.followingWin.toString()))
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ],
                        ),
            );
          }),
        ),
      ),
    );
  }
}
