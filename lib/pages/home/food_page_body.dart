import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_firstapp/controllers/popular_product_controller.dart';
import 'package:my_firstapp/controllers/recommended_product_controller.dart';
import 'package:my_firstapp/helper/model/products_model.dart';
import 'package:my_firstapp/pages/food/popular_food_detail.dart';
import 'package:my_firstapp/routes/route_helper.dart';
import 'package:my_firstapp/utils/app_constants.dart';
import 'package:my_firstapp/utils/colors.dart';
import 'package:my_firstapp/utils/dimensions.dart';
import 'package:my_firstapp/widgets/app_column.dart';
import 'package:my_firstapp/widgets/big_text.dart';
import 'package:my_firstapp/widgets/icon_and_text_widget.dart';
import 'package:my_firstapp/widgets/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;
  @override
  void initState() {
    // TODO: implement initState
      super.initState();
      pageController.addListener(() {setState(() {
        _currPageValue = pageController.page!;

      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    //super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ////////////////////////////////////SLIDER SECTION
        GetBuilder<PopularProductController>(builder: (popularProducts){
          print("the length "+popularProducts.popularProductList.length.toString());
          return popularProducts.isLoaded?Container(
            //color: Colors.red,
            height: Dimensions.pageView,

            child: PageView.builder(
                controller: pageController,
                itemCount: popularProducts.popularProductList.length,
                itemBuilder: (context, position){
                  return _buildPageItem(position, popularProducts.popularProductList[position]);// the widget that returns the index position
                }),

          ):CircularProgressIndicator(
            color: AppColors.maincolor,
          );
        }),
        ////////////////////////////////////DOTS
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.maincolor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radius30)),
            ),
          );
        }),
        ////////////////////////////////////POPULAR TEXT
        SizedBox(height: Dimensions.height20,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: "Recommended"),
                SizedBox(width: Dimensions.width10,),
                Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: BigText(text: ".", color: Colors.black26),
                ),
                SizedBox(width: Dimensions.width10,),
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: SmallText(text: "Food pairing",),
                )
              ],
            ),
        ),
        ///////////////////////////////////LIST OF FOOD AND IMAGES
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
          return recommendedProduct.isLoaded?ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getRecommendedFood(index));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20, bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        //image section
                        Container(
                          width: Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white38,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!
                                )
                            ),
                          ),
                        ),
                        //text container
                        Expanded(child: Container(
                          height: Dimensions.listViewTextContSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius20),
                              bottomRight: Radius.circular(Dimensions.radius20),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                SizedBox(height: Dimensions.height10,),
                                SmallText(text: "With chinese characteristics"),
                                SizedBox(height: Dimensions.height10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
                                    IconAndTextWidget(icon: Icons.location_on, text: "1.7km", iconColor: AppColors.maincolor),
                                    IconAndTextWidget(icon: Icons.access_time, text: "32min", iconColor: AppColors.iconColor2)
                                  ],
                                )

                              ],
                            ),
                          ),
                        ))
                        //text container widget
                        //_buildPageItem2(),
                      ],
                    ),
                  ),
                );
              }):CircularProgressIndicator(
            color: AppColors.maincolor,
          );
        })

      ],
    );
  }
  Widget _buildPageItem(int index, ProductModel popularProduct){
    Matrix4 matrix = new Matrix4.identity();
    if(index == _currPageValue.floor()){//current slide
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index == _currPageValue.floor()+1) {//+1 next slide
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index == _currPageValue.floor()-1) {//-1 prev slide
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }
    // const Card(
    //   child: Padding(
    //     padding: EdgeInsets.all(16.0),
    //     child: Text('Hello World!'),
    //   ),
    // );
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){

              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimensions.pageViewContainer, margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: index.isEven?Color(0xFF69c5df):Color(0xFF9294df),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!
                      //"assets/image/jew.jpg"
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(

              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30 , bottom: Dimensions.height30),

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 15.5,
                        spreadRadius: 1.0,
                        blurStyle: BlurStyle.normal)]
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15, left: 15, right: 15),
                child: AppColumn(text:popularProduct.name!),//! not empty
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildPageItem2(){
    return Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      bottomRight: Radius.circular(Dimensions.radius20)
                  ),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 15.5,
                        spreadRadius: 1.0,
                        blurStyle: BlurStyle.normal)]
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height10, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: "Nutrition Fruits"),
                    SizedBox(height: Dimensions.height10,),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(5, (index) => Icon(Icons.star, color: AppColors.maincolor, size: 15,)),
                        ),
                        SizedBox(width: 15,),
                        SmallText(text: "4.8"),
                        SizedBox(width: 15,),
                        SmallText(text: "1234, comments")
                      ],
                    ),
                    SizedBox(height: Dimensions.height10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
                        IconAndTextWidget(icon: Icons.location_on, text: "1.7km", iconColor: AppColors.maincolor),
                        IconAndTextWidget(icon: Icons.access_time, text: "32min", iconColor: AppColors.iconColor2)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
