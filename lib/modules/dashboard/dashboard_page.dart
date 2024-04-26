import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:texo_it_films/core/utils/custom_responsive.dart';
import '../../core/components/layout/layout_base.dart';
import './dashboard_controller.dart';
import 'widgets/card_min_max_producers_widget.dart';
import 'widgets/card_multiple_winners_widget.dart';
import 'widgets/card_top_studios_widget.dart';
import 'widgets/card_winner_by_year_widget.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBase(
      content: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: LayoutBuilder(builder: (context, constraints) {
            return Visibility(
              visible: CustomResponsive.width > 1190,
              replacement: Column(
                children: [
                  CardMultipleWinnersWidget(controller: controller),
                  const SizedBox(height: 16),
                  CardTopStudiosWidget(controller: controller),
                  const SizedBox(height: 16),
                  CardMinMaxProducersWidget(controller: controller),
                  const SizedBox(height: 16),
                  CardWinnerByYearWidget(controller: controller),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CardMultipleWinnersWidget(controller: controller),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: CardTopStudiosWidget(controller: controller),
                      ),
                      if (CustomResponsive.isUltraWideDesktop) const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CardMinMaxProducersWidget(controller: controller),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: CardWinnerByYearWidget(controller: controller),
                      ),
                      if (CustomResponsive.isUltraWideDesktop) const Spacer(),
                    ],
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
