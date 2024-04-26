import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dashboard_controller.dart';
import 'default_title_table_widget.dart';
import 'error_dashboard_widget.dart';
import 'loading_dashboard_widget.dart';
import 'title_dashboard_widget.dart';

class CardTopStudiosWidget extends StatelessWidget {
  final DashboardController controller;

  const CardTopStudiosWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 230),
          child: Obx(
            () {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: controller.statusTopStudios.isLoading
                    ? const LoadingDashboardWidget()
                    : controller.statusTopStudios.isError
                        ? ErrorDashboardWidget(onPressed: controller.getTopStudios)
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const TitleDashboardWidget(title: 'Top 3 studios with winners'),
                              const SizedBox(height: 10),
                              DataTable(
                                headingRowHeight: 40,
                                headingRowColor: MaterialStatePropertyAll(Colors.grey.shade200),
                                border: TableBorder.all(
                                    color: Colors.grey.shade400, width: 3, borderRadius: BorderRadius.circular(4)),
                                columns: const [
                                  DataColumn(label: DefaultTitleTableWidget(text: 'Name')),
                                  DataColumn(label: DefaultTitleTableWidget(text: 'Win Count')),
                                ],
                                rows: controller.topStudiosModel!.studios
                                    .take(3)
                                    .map(
                                      (e) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              e.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              e.winCount.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
              );
            },
          ),
        ),
      ),
    );
  }
}
