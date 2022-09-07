import 'package:get/get.dart';
import 'package:my_firstapp/controllers/popular_product_controller.dart';
import 'package:my_firstapp/data/api/api_client.dart';
import 'package:my_firstapp/data/repository/popular_product_repo.dart';
import 'package:my_firstapp/utils/app_constants.dart';

import '../controllers/recommended_product_controller.dart';
import '../data/repository/recommeded_product_repo.dart';

Future<void> init()async{
  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL));
  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
}