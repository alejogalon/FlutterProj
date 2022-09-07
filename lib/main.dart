import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_firstapp/controllers/popular_product_controller.dart';
import 'package:my_firstapp/controllers/recommended_product_controller.dart';
import 'package:my_firstapp/pages/food/popular_food_detail.dart';
import 'package:my_firstapp/pages/food/recommended_food_detail.dart';
import 'package:my_firstapp/pages/home/food_page_body.dart';
import 'package:my_firstapp/pages/home/main_food_page.dart';
import 'package:my_firstapp/routes/route_helper.dart';
import 'helper/dependencies.dart' as dep;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();//ensures loaded correctly
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MainFoodPage(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,//const MyHomePage(title: 'Flutter try Home Page'),
    );
  }
}
