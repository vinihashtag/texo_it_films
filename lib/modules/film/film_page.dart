import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texo_it_films/core/enums/type_winner_filter_enum.dart';
import 'package:texo_it_films/data/models/film_pagination_model.dart';

import '../../core/components/layout/layout_base.dart';
import '../dashboard/widgets/error_dashboard_widget.dart';
import '../dashboard/widgets/loading_dashboard_widget.dart';
import './film_controller.dart';

class FilmPage extends GetView<FilmController> {
  const FilmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBase(
      content: Obx(
        () {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: controller.status.isLoading
                ? const LoadingDashboardWidget()
                : controller.status.isError
                    ? ErrorDashboardWidget(onPressed: () => controller.getFilmsByFilter(refresh: true))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'List movies',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Flexible(
                            child: PaginatedDataTable2(
                              headingRowHeight: 95,
                              headingRowColor: MaterialStatePropertyAll(Colors.grey.shade200),
                              border: TableBorder.all(
                                  color: Colors.grey.shade400, width: 3, borderRadius: BorderRadius.circular(4)),
                              columns: [
                                const DataColumn(
                                  label: Text(
                                    'ID',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                                  ),
                                ),
                                DataColumn(
                                  label: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Year',
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                                      ),
                                      const SizedBox(height: 8),
                                      DropdownButtonFormField<String?>(
                                        isDense: true,
                                        isExpanded: true,
                                        value: controller.yearSelected?.toString(),
                                        hint: Text(
                                          'Filter by year',
                                          style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                                        ),
                                        items: List.generate(
                                          DateTime.now().year - 1899,
                                          (index) => (DateTime.now().year - index).toString(),
                                        ).map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value.toString()),
                                          );
                                        }).toList()
                                          ..insert(
                                            0,
                                            const DropdownMenuItem<String>(
                                              value: 'TODOS',
                                              child: Text('TODOS'),
                                            ),
                                          ),
                                        onChanged: (v) {
                                          if (v?.contains('TODOS') ?? false) {
                                            controller.yearSelected = null;
                                          } else {
                                            controller.yearSelected = v == null ? null : int.parse(v);
                                          }

                                          controller.getFilmsByFilter(refresh: true);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                const DataColumn(
                                  label: Text(
                                    'Title',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                                  ),
                                ),
                                DataColumn(
                                  label: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Winner?',
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                                      ),
                                      const SizedBox(height: 8),
                                      DropdownButtonFormField(
                                        isDense: true,
                                        isExpanded: true,
                                        value: controller.winnerFilter,
                                        hint: Text(
                                          'Yes/No',
                                          style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                                        ),
                                        items: TypeWinnerFilterEnum.values
                                            .map<DropdownMenuItem<TypeWinnerFilterEnum>>((TypeWinnerFilterEnum value) {
                                          return DropdownMenuItem<TypeWinnerFilterEnum>(
                                            value: value,
                                            child: Text(value.text),
                                          );
                                        }).toList(),
                                        onChanged: (v) {
                                          if (v != null) {
                                            controller.winnerFilter = v;

                                            controller.getFilmsByFilter(refresh: true);
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                              source: _DataSource(data: controller.filmPaginationModel!.content),
                              rowsPerPage: 15,
                              availableRowsPerPage: const [15, 30, 50, 100],
                              showFirstLastButtons: false,
                              hidePaginator: true,
                              wrapInCard: false,
                              empty: const SizedBox(),
                              renderEmptyRowsInTheEnd: false,
                            ),
                          ),
                          Visibility(
                            visible: !controller.hasFilter,
                            child: Material(
                              color: Colors.grey.shade300,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: controller.currentPage <= 0
                                        ? null
                                        : () => controller.getFilmsByFilter(refresh: true),
                                    icon: const Icon(Icons.first_page),
                                  ),
                                  IconButton(
                                    onPressed: controller.currentPage <= 0
                                        ? null
                                        : () => controller.getFilmsByFilter(
                                            refresh: true, selectedPage: controller.currentPage - 1),
                                    icon: const Icon(Icons.arrow_left_outlined),
                                  ),
                                  ...List.generate(
                                    controller.filmPaginationModel!.totalPages,
                                    (v) {
                                      final int page = v;
                                      return InkWell(
                                        onTap: () => controller.getFilmsByFilter(refresh: true, selectedPage: page),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                          color: controller.currentPage == page
                                              ? Colors.blue.shade600
                                              : Colors.transparent,
                                          child: Text(
                                            (page + 1).toString(),
                                            style: TextStyle(
                                                color: controller.currentPage == page ? Colors.white : Colors.black54),
                                          ),
                                        ),
                                      );
                                    },
                                  ).sublist(controller.twoPreviousPage, controller.twoNextPage),
                                  IconButton(
                                    onPressed: !controller.hasMoreData
                                        ? null
                                        : () => controller.getFilmsByFilter(
                                            refresh: true, selectedPage: controller.currentPage + 1),
                                    icon: const Icon(Icons.arrow_right_outlined),
                                  ),
                                  IconButton(
                                    onPressed: !controller.hasMoreData
                                        ? null
                                        : () => controller.getFilmsByFilter(
                                              refresh: true,
                                              selectedPage: controller.filmPaginationModel!.totalPages - 1,
                                            ),
                                    icon: const Icon(Icons.last_page),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
          );
        },
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<ContentModel> data;

  _DataSource({required this.data});

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;

    final ContentModel item = data[index];

    return DataRow(
      cells: [
        DataCell(Text(item.id.toString())),
        DataCell(Text(item.year.toString())),
        DataCell(Text(item.title.toString())),
        DataCell(Text(item.winner ? 'Yes' : 'No'))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
