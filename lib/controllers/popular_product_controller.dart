import 'dart:isolate';

import 'package:get/get.dart';
import 'package:my_firstapp/data/repository/popular_product_repo.dart';

import '../helper/model/products_model.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  //constructor
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded=>_isLoaded;

  int _quantity = 0;
  int get quantity=>_quantity;

  Future<void> getPopularProductList() async{//async if it returns a future data
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode==200){
      print("got products");
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductList);
      _isLoaded = true;
      update();//same as setState()
    }else{

    }
  }

  void setQuantity(bool isIncreement){
    if(isIncreement){
      print("increement");
      _quantity = _quantity+1;
    }else{
      _quantity = _quantity-1;
    }
  }
}