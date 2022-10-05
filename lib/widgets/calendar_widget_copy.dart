import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_firstapp/utils/colors.dart';
import 'package:my_firstapp/utils/dimensions.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../pages/Scheduler/event_editing_page.dart';
import '../pages/Scheduler/show_details_event.dart';
import '../pages/food/recommended_food_detail.dart';
import '../utils/app_constants.dart';

/*
void main() {
  return runApp(CalendarWidgetCopy());
}*/

/// Global key used to maintain the state, when we change the parent of the
/// widget
final GlobalKey _globalKey = GlobalKey();
class CalendarWidgetCopy extends StatelessWidget {
  const CalendarWidgetCopy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    Widget calendar = Theme(

      /// The key set here to maintain the state,
      ///  when we change the parent of the widget
        //key: _globalKey,
        data: ThemeData.dark(),
        child:  _getHeatMapCalendar(context),
    );
    return Scaffold(
      backgroundColor: AppColors.signColor,
      body: Container(
        color: AppColors.maincolor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(Dimensions.height10),
              child: CircleAvatar(
                radius: Dimensions.height30,
                backgroundImage: const ExactAssetImage(
                  AppConstants.PROFILE_PICTURE_URL
                )
              ),
            ),
            Expanded(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child:
                        Container(
                          //color: AppColors.signColor,
                            constraints: BoxConstraints.expand(),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/image/bgb.jpg"), fit: BoxFit.cover)
                          ),
                          //color: AppColors.signColor,
                            child: calendar,
                        ),
                      )
                    ])),

          ],
        ),
      ),
    );
  }
}

/// Returns the calendar widget based on the properties passed.
SfCalendar _getHeatMapCalendar(BuildContext context) {
  return SfCalendar(
      allowedViews: const <CalendarView>[
        CalendarView.day,
        CalendarView.week,
        CalendarView.workWeek,
        CalendarView.month,
        CalendarView.timelineDay,
        CalendarView.timelineWeek,
        CalendarView.timelineWorkWeek,
        CalendarView.timelineMonth,
        CalendarView.schedule
      ],
      //showNavigationArrow: true,
      backgroundColor: Colors.transparent,
      cellBorderColor: Colors.white,
    headerStyle: CalendarHeaderStyle(
        textAlign: TextAlign.center,
        backgroundColor: AppColors.blueColor,
        textStyle: TextStyle(
            fontSize: Dimensions.font26,
            fontStyle: FontStyle.normal,
            color: AppColors.iconColor1,
            fontWeight: FontWeight.w500)),
      viewHeaderStyle: ViewHeaderStyle(
          dayTextStyle: TextStyle(color: Colors.white),
          dateTextStyle: TextStyle(color: Colors.white)),
      timeSlotViewSettings: TimeSlotViewSettings(
          timeTextStyle: TextStyle(color: Colors.white)),
      monthViewSettings: MonthViewSettings(
          dayFormat: 'EEE',
          showTrailingAndLeadingDates: false,
          monthCellStyle: MonthCellStyle(
              textStyle: TextStyle(color: Colors.white),
              leadingDatesTextStyle: TextStyle(color: Colors.white),
              trailingDatesTextStyle:
              TextStyle(color: Colors.white))),
      scheduleViewSettings: ScheduleViewSettings(
          monthHeaderSettings: MonthHeaderSettings(
              backgroundColor: Colors.transparent,
              monthTextStyle: TextStyle(color: AppColors.redColor))
      ),
      view: CalendarView.month,
      monthCellBuilder: _monthCellBuilder,
      showDatePickerButton: true,
      /*monthViewSettings: const MonthViewSettings(
        showTrailingAndLeadingDates: false,
      )*/
      onLongPress: (details){
        calendarTapped(context);
      },
  );
}
/// Returns the builder for month cell.
Widget _monthCellBuilder(BuildContext buildContext, MonthCellDetails details) {
  final Color backgroundColor = _getMonthCellBackgroundColor(details.date);
  final Color defaultColor = AppColors.paraColor;
  final bool isSpecialNoneWorkingDate = isSpecialNoneWorkingDay(details.date);
  final bool isNoneWorkingDate = isNoneWorkingDay(details.date);
  final bool isVacationLeaveDate = isVacationLeaveDay(details.date);
  final bool isVacationLeaveApprovedDate = isVacationLeaveApproveDay(details.date);
  final bool isNoScheduleDate = isNoScheduleDay(details.date);
  final bool isOTDetailsDate = isOTDetailsDay(details.date);
  return Container(//
    decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: defaultColor, width: 1)
    ),
    child: Center(
      child: Column(
        children: [
          SizedBox(height: Dimensions.height10,),
          Text(
            details.date.day.toString(),
            style: TextStyle(
                fontWeight: FontWeight.w800,
                color:
                isSpecialNoneWorkingDate?
                AppColors.redColor:
                isNoneWorkingDate?
                AppColors.maincolor:
                AppColors.mainBlackColor
            ),
          ),
          isSpecialNoneWorkingDate?Row():
          isNoneWorkingDate?Row():
          isNoScheduleDate?Row():
          Row(
            children: [
              Text(
                "06:00 AM",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: Dimensions.width10,
                ),
              ),
            ],
          ),
          Row(
            children: [
              !isVacationLeaveDate?Container():
              Icon(
                Icons.calendar_month_outlined,
                color: AppColors.redColor,
                size: Dimensions.font16,
              ),
              !isVacationLeaveApprovedDate?Container():
              Icon(
                Icons.fact_check,
                color: AppColors.kDarkerGreen,
                size: Dimensions.font16,
              ),
              !isOTDetailsDate?Container():
              Icon(
                Icons.more_time,
                color: AppColors.redColor,
                size: Dimensions.font16,
              ),
              !isNoScheduleDate?Container():
              Container(
                padding: EdgeInsets.only(top:Dimensions.height10,
                left: Dimensions.width20),
                child: Icon(
                  Icons.warning_amber_outlined,
                  color: AppColors.maincolor,
                  size: Dimensions.font16,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

String? _subjectText = '',
    _startTimeText = '',
    _endTimeText = '',
    _dateText = '',
    _timeDetails = '';
Color? _headerColor, _viewHeaderColor, _calendarColor;

void calendarTapped(BuildContext context) {
  /*showModalBottomSheet(
      context: context,
      builder: (context) => RecommendedFoodDetail(pageId: 1,),

      
  );*/
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 1,
          child: ShowDetailsEventDate(pageId: 1,),
        );
      });

/*
  Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return RecommendedFoodDetail(pageId: 1,);
      },
      fullscreenDialog: true
  ));*/
}


Color _getMonthCellBackgroundColor(DateTime date) {
  if (date.month.isOdd) {
    if (date.day % 6 == 0) {
      // 6, 12, 18, 24, 30
      return AppColors.kDarkerGreen;
    } else if (date.day % 5 == 0) {
      // 5, 10, 15, 20, 25
      return AppColors.kMidGreen;
    } else if (date.day % 8 == 0 || date.day % 4 == 0) {
      //  4, 8, 16, 24, 28
      return AppColors.kDarkGreen;
    } else if (date.day % 9 == 0 || date.day % 3 == 0) {
      // 3, 9, 18, 21, 27
      return AppColors.kLightGrey;
    } else {
      // 1, 2, 7, 11, 13, 19, 22, 23, 26, 29
      return AppColors.kLightGreen;
    }
  } else if (date.month == 10) {
    if (date.day == 9) {
      // 9
      return AppColors.orangeColor;
    }
    else if(isNoneWorkingDay(date)){
      return Colors.deepPurpleAccent;
    }
    else if(isNoScheduleDay(date)){
      return Colors.redAccent;
    }
    return AppColors.kLightGrey;
  }  else {
    if (date.day % 6 == 0) {
      // 6, 12, 18, 24, 30
      return AppColors.kLightGreen;
    } else if (date.day % 5 == 0) {
      // 5, 10, 15, 20, 25
      return AppColors.kLightGrey;
    } else if (date.day % 8 == 0 || date.day % 4 == 0) {
      //  4, 8, 16, 24, 28
      return AppColors.kMidGreen;
    } else if (date.day % 9 == 0 || date.day % 3 == 0) {
      // 3, 9, 18, 21, 27
      return AppColors.kDarkerGreen;
    } else {
      // 1, 2, 7, 11, 13, 19, 22, 23, 26, 29
      return AppColors.kDarkGreen;
    }
  }
}
bool isMonthOf(DateTime dateTime,int month){
  if(dateTime.month==month){
    return true;
  }
  return false;
}
bool isSpecialNoneWorkingDay(DateTime dateTime){
  if(isMonthOf(dateTime,10)){
    if(dateTime.day==9) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}
bool isNoneWorkingDay(DateTime dateTime){
  if(isMonthOf(dateTime,10)){
    if(dateTime.day==4 || dateTime.day==11 || dateTime.day==18 || dateTime.day==25) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}
bool isVacationLeaveDay(DateTime dateTime){
  if(isMonthOf(dateTime,10)){
    if(dateTime.day==6) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}
bool isVacationLeaveApproveDay(DateTime dateTime){
  if(isMonthOf(dateTime,10)){
    if(dateTime.day==7) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}
bool isNoScheduleDay(DateTime dateTime){
  if(isMonthOf(dateTime,10)){
    if(dateTime.day==19||dateTime.day==20||dateTime.day==21||dateTime.day==22||dateTime.day==23) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}
bool isOTDetailsDay(DateTime dateTime){
  if(isMonthOf(dateTime,10)){
    if(dateTime.day==27) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}