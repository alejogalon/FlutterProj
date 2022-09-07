import 'package:get/get.dart';
import 'package:my_firstapp/pages/food/popular_food_detail.dart';
import 'package:my_firstapp/pages/home/main_food_page.dart';

import '../pages/food/recommended_food_detail.dart';

class RouteHelper{
  static const String initial ="/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";

  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId)=>'$popularFood?pageId=$pageId';//receives a parameter
  static String getRecommendedFood(int pageId)=>'$recommendedFood?pageId=$pageId';//receives a parameter

  static List<GetPage> routes =[
    GetPage(name:initial, page: ()=>MainFoodPage()),
    GetPage(name: popularFood, page:(){
      //print("popular food get called");
      var pageId=Get.parameters['pageId'];
      return PopularFoodDetail(pageId:int.parse(pageId!));
    },
      transition: Transition.fadeIn
    ),
    GetPage(name: recommendedFood, page:(){
      //print("popular food get called");
      var pageId=Get.parameters['pageId'];
      return RecommendedFoodDetail(pageId:int.parse(pageId!));
    },
        transition: Transition.fadeIn
    ),
  ];
}