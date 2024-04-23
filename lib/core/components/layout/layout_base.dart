import 'package:flutter/material.dart';
import 'package:texo_it_films/core/components/drawer/custom_drawer.dart';

class LayoutBase extends StatelessWidget {
  final Widget content;
  final AppBar? appBarCustom;
  final String titleAppBar;
  const LayoutBase({super.key, required this.content, this.appBarCustom, this.titleAppBar = 'Frontend Flutter Test'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarCustom ?? (titleAppBar.isEmpty ? null : AppBar(title: Text(titleAppBar))),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomDrawer(),
            Expanded(child: Padding(padding: const EdgeInsets.fromLTRB(24, 8, 24, 48), child: content))
          ],
        ));
  }
}
