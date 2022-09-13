import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_firstapp/utils/colors.dart';
import 'package:my_firstapp/utils/dimensions.dart';

import '../../utils/app_constants.dart';
import '../Dashboard/Dashboard_page.dart';
import '../Scheduler/Work_scheduler.dart';
import '../User/UserPage.dart';
import '../home/main_food_page.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ),
  );
  Widget buildHeader<PopularProductController>(BuildContext context) => Material(
    color: AppColors.maincolor,
    child: InkWell(
      onTap: (){
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const UserPage()));
      },
      child: Container(
        padding: EdgeInsets.only(
          top: Dimensions.width10 + MediaQuery.of(context).padding.top,
          bottom: Dimensions.width15,
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 52,
                backgroundImage: NetworkImage(
                    AppConstants.PROFILE_PICTURE_URL
                ),
            ),
            SizedBox(height: Dimensions.height10),
            Text(
              'Name Surename',
              style: TextStyle(fontSize: Dimensions.width15,
                  color: AppColors.mainBlackColor),
            ),
            Text(
              'email@email.com',
              style: TextStyle(fontSize: Dimensions.width10,
                  color: AppColors.mainBlackColor),
            ),
          ],
        ),
      ),
    ),
  );
  Widget buildMenuItems(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      runSpacing: Dimensions.height15,
      children: [
        ListTile(
          leading: const Icon(Icons.dashboard_outlined),
          title: const Text("Dashboard"),
            onTap: () {
              //close navigation drawer before
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DashboardPage()));
            }
        ),
        ListTile(
          leading: const Icon(Icons.list_alt_outlined),
          title: const Text("Schedule Viewer"),
            onTap: () {
            //close navigation drawer before
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const WorkScheduler()));
            }
        ),
        ListTile(
          leading: const Icon(Icons.house_outlined),
          title: const Text("Marketplace"),
            onTap: () {
              //close navigation drawer before
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MainFoodPage()));
            }
        ),
        ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text("My Profile"),
            onTap: () {
              //close navigation drawer before
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const UserPage()));
            }
        ),
        const Divider(color: Colors.black54),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text("Settings"),
          onTap: (){},
        ),
      ],
    ),
  );
}
