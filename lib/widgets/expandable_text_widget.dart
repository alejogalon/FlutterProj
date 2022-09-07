import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_firstapp/utils/colors.dart';
import 'package:my_firstapp/utils/dimensions.dart';

import 'small_text.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight/2.63;
//i love flutter laravel and golang 30
  @override
  void initState(){
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1, widget.text.length);
    }
    else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(color: AppColors.paraColor, size:Dimensions.font16, text: firstHalf):Column(
        children: [
          SmallText(height: 1.8, color:AppColors.paraColor , size: Dimensions.font16, text: hiddenText?(firstHalf+"..."):(firstHalf+secondHalf)),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText=!hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text: hiddenText?"Show more":"Show less", color: AppColors.maincolor,),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up, color: AppColors.maincolor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
