import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texo_it_films/modules/dashboard/dashboard_controller.dart';

import 'default_title_table_widget.dart';
import 'error_dashboard_widget.dart';
import 'loading_dashboard_widget.dart';
import 'title_dashboard_widget.dart';

class CardWinnerByYearWidget extends StatelessWidget {
  final DashboardController controller;

  const CardWinnerByYearWidget({super.key, required this.controller});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const TitleDashboardWidget(title: 'List movie winners by year'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      isDense: true,
                      isExpanded: true,
                      hint: Text(
                        'Search by year',
                        style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                      ),
                      items: List.generate(
                        DateTime.now().year - 1899,
                        (index) => DateTime.now().year - index,
                      ).map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (v) => controller.yearSelected = v ?? DateTime.now().year,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(
                    () => AbsorbPointer(
                      absorbing: controller.statusWinnersByYear.isLoading,
                      child: IconButton.filled(
                        style: IconButton.styleFrom(
                            backgroundColor: Colors.blue.shade800,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                        onPressed: controller.yearSelected == null
                            ? null
                            : () => controller.getWinnersByYear(controller.yearSelected!),
                        icon: const Icon(Icons.search, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Obx(() {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: controller.statusWinnersByYear.isLoading
                      ? const LoadingDashboardWidget(height: 100)
                      : controller.statusWinnersByYear.isError
                          ? ErrorDashboardWidget(onPressed: () => controller.getWinnersByYear(controller.yearSelected!))
                          : SizedBox(
                              width: double.maxFinite,
                              child: DataTable(
                                headingRowHeight: 40,
                                headingRowColor: MaterialStatePropertyAll(Colors.grey.shade200),
                                border: TableBorder.all(
                                    color: Colors.grey.shade400, width: 3, borderRadius: BorderRadius.circular(4)),
                                columns: const [
                                  DataColumn(label: DefaultTitleTableWidget(text: 'ID')),
                                  DataColumn(label: DefaultTitleTableWidget(text: 'Year')),
                                  DataColumn(label: DefaultTitleTableWidget(text: 'Title')),
                                ],
                                rows: controller.listWinnersByYear
                                    .map(
                                      (e) => DataRow(
                                        cells: [
                                          DataCell(Text(e.id.toString())),
                                          DataCell(Text(e.year.toString())),
                                          DataCell(Text(e.title)),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
