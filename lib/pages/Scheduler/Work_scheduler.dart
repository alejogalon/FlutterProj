import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_firstapp/pages/Navigation/Navigation_drawer.dart';
import 'package:my_firstapp/utils/colors.dart';

import '../../widgets/CalendarWidget.dart';
import 'event_editing_page.dart';

class WorkScheduler extends StatelessWidget {
  const WorkScheduler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: NavigationDrawer(),
    appBar: AppBar(
      title: const Text("Scheduler Viewer"),
      backgroundColor: AppColors.maincolor,
    ),
    body: CalendarWidget(),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add, color: AppColors.mainBlackColor),
      backgroundColor: AppColors.maincolor,
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => EventEditingPage())
      ),
    ),
  );
}
