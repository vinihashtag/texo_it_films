import 'package:flutter/material.dart';
import 'package:texo_it_films/core/components/drawer/custom_drawer.dart';
import 'package:texo_it_films/core/utils/custom_responsive.dart';

class LayoutBase extends StatelessWidget {
  final Widget content;
  final AppBar? appBarCustom;
  final String titleAppBar;
  final EdgeInsets? padding;
  const LayoutBase({
    super.key,
    required this.content,
    this.appBarCustom,
    this.titleAppBar = 'Frontend Flutter Test',
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          drawer: CustomResponsive.isMobile ? const CustomDrawer() : null,
          appBar: appBarCustom ??
              (titleAppBar.isEmpty
                  ? null
                  : AppBar(
                      title: Text(titleAppBar),
                    )),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: CustomResponsive.isMobile
                ? content
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomDrawer(width: constraints.maxWidth * .15 < 250 ? 200 : constraints.maxWidth * .15),
                      Expanded(
                        child: Padding(padding: padding ?? const EdgeInsets.fromLTRB(24, 8, 24, 8), child: content),
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }
}
