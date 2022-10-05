import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_firstapp/controllers/recommended_product_controller.dart';
import 'package:my_firstapp/routes/route_helper.dart';
import 'package:my_firstapp/utils/app_constants.dart';
import 'package:my_firstapp/utils/colors.dart';
import 'package:my_firstapp/utils/dimensions.dart';
import 'package:my_firstapp/widgets/app_icon.dart';
import 'package:my_firstapp/widgets/big_text.dart';
import 'package:my_firstapp/widgets/expandable_text_widget.dart';

import 'Work_scheduler.dart';

class ShowDetailsEventDate extends StatelessWidget {
  final int pageId;
  const ShowDetailsEventDate({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 120,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: AppIcon(icon: Icons.clear),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: Container(
                child: Center(child: BigText(size: Dimensions.font26 ,text: product.name!)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20))
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.maincolor,
            expandedHeight: 130,
            flexibleSpace: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: Dimensions.height30),
                  child: CircleAvatar(
                      radius: Dimensions.height30,
                      backgroundImage: const ExactAssetImage(
                          AppConstants.PROFILE_PICTURE_URL
                      )
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableText(text: product.description!),
                  margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                )
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: Dimensions.height10,bottom: Dimensions.height10,
              left: Dimensions.width20*2.5,right: Dimensions.width20*2.5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(iconSize: Dimensions.iconSize24, iconColor: Colors.white,backgroundColor: AppColors.maincolor,icon: Icons.remove),
                BigText(text: "\$ ${product.price!} X 0",color: AppColors.mainBlackColor,size: Dimensions.font26,),
                AppIcon(iconSize: Dimensions.iconSize24, iconColor: Colors.white,backgroundColor: AppColors.maincolor,icon: Icons.add),
              ],
            ),
          ),
          Container(
            height: Dimensions.bottomHeight,
            padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,
              left: Dimensions.width20,right: Dimensions.width20,
            ),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20*2),
                    topRight: Radius.circular(Dimensions.radius20*2)
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20,left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.maincolor,
                  )
                ),
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,
                    left: Dimensions.width20,right: Dimensions.width20,
                  ),
                  child: BigText(text: "\$10 | Add to cart",color: Colors.white,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.maincolor
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
