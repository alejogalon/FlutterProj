import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text_widget.dart';
import '../Navigation/Navigation_drawer.dart';
import '../Scheduler/Work_scheduler.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: NavigationDrawer(),
    appBar: AppBar(
      title: const Text("Name Surename"),
      backgroundColor: AppColors.maincolor,
    ),
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          pinned: true,
          backgroundColor: AppColors.yellowColor,
          expandedHeight: 400,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              AppConstants.PROFILE_PICTURE_URL,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );
}
