import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_firstapp/pages/Navigation/Navigation_drawer.dart';
import 'package:my_firstapp/utils/colors.dart';

class WorkScheduler extends StatelessWidget {
  const WorkScheduler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: NavigationDrawer(),
    appBar: AppBar(
      title: const Text("Scheduler Viewer"),
      backgroundColor: AppColors.maincolor,
    ),
  );
}
