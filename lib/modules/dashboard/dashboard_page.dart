import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../core/components/layout/layout_base.dart';
import './dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBase(
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'List yeras with mutiple winners',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          DataTable(
                            headingRowColor: MaterialStatePropertyAll(Colors.grey.shade200),
                            border: TableBorder.all(
                                color: Colors.grey.shade400, width: 3, borderRadius: BorderRadius.circular(4)),
                            columns: const [
                              DataColumn(
                                  label: Text('Year',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87))),
                              DataColumn(
                                  label: Text('Win Count',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87))),
                            ],
                            rows: const [
                              DataRow(cells: [
                                DataCell(Text('2019')),
                                DataCell(Text('10')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('2020')),
                                DataCell(Text('15')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('2021')),
                                DataCell(Text('20')),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Top 3 studios with winners',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          DataTable(
                            headingRowColor: MaterialStatePropertyAll(Colors.grey.shade200),
                            border: TableBorder.all(
                                color: Colors.grey.shade400, width: 3, borderRadius: BorderRadius.circular(4)),
                            columns: const [
                              DataColumn(
                                  label: Text('Name',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87))),
                              DataColumn(
                                  label: Text('Win Count',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87))),
                            ],
                            rows: const [
                              DataRow(cells: [
                                DataCell(Text('2019')),
                                DataCell(Text('10')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('2020')),
                                DataCell(Text('15')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('2021')),
                                DataCell(Text('20')),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'List yeras with mutiple winners',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          DataTable(
                            border: TableBorder.all(),
                            columns: const [
                              DataColumn(label: Text('Year')),
                              DataColumn(label: Text('Win Count')),
                            ],
                            rows: const [
                              DataRow(cells: [
                                DataCell(Text('2019')),
                                DataCell(Text('10')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('2020')),
                                DataCell(Text('15')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('2021')),
                                DataCell(Text('20')),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Top 3 studios with winners',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          DataTable(
                            border: TableBorder.all(),
                            columns: const [
                              DataColumn(label: Text('Year')),
                              DataColumn(label: Text('Win Count')),
                            ],
                            rows: const [
                              DataRow(cells: [
                                DataCell(Text('2019')),
                                DataCell(Text('10')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('2020')),
                                DataCell(Text('15')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('2021')),
                                DataCell(Text('20')),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
