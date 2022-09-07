import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_firstapp/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10,),
        //comments section
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
        SizedBox(height: Dimensions.height20,),
        //time and distance
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
            IconAndTextWidget(icon: Icons.location_on, text: "1.7km", iconColor: AppColors.maincolor),
            IconAndTextWidget(icon: Icons.access_time, text: "32min", iconColor: AppColors.iconColor2)
          ],
        )
      ],
    );
  }
}
