import 'dart:isolate';

import 'package:get/get.dart';
import 'package:my_firstapp/data/repository/popular_product_repo.dart';

import '../data/repository/recommeded_product_repo.dart';
import '../helper/model/products_model.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  //constructor
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductRepoList = [];
  List<dynamic> get recommendedProductList => _recommendedProductRepoList;

  bool _isLoaded = false;
  bool get isLoaded=>_isLoaded;
  Future<void> getRecommendedProductList() async{//async if it returns a future data
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode==200){
      print("got products recommended");
      _recommendedProductRepoList=[];
      _recommendedProductRepoList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductList);
      _isLoaded = true;
      update();//same as setState()
    }else{
      print("not got products");

    }
  }
}