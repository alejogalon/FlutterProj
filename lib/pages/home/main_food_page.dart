import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_firstapp/utils/colors.dart';
import 'package:my_firstapp/utils/dimensions.dart';
import 'package:my_firstapp/widgets/big_text.dart';
import 'package:my_firstapp/widgets/small_text.dart';

import '../Navigation/Navigation_drawer.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    print("current height is "+ MediaQuery.of(context).size.height.toString());
    print("current width is "+ MediaQuery.of(context).size.width.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Marketplace"),
        backgroundColor: AppColors.maincolor,
      ),
      drawer: const NavigationDrawer(),
      body: Column(
        children: [
          //header
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Center(
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius10),
                        color: AppColors.maincolor,
                      ),
                      child: Icon(Icons.search,color: Colors.white, size: Dimensions.iconSize24,),
                    ),
                  ),
                  Column(
                    children: [
                      BigText(text: "Philippines", color: AppColors.maincolor,),
                      Row(
                        children: [
                          SmallText(text: "Cebu", color: Colors.black54,),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),

          ),
          //body
          Expanded(child: SingleChildScrollView(
           child:  FoodPageBody(),
         ))
        ],
      ),
    );
  }
}
