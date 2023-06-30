import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class TitleRow extends StatelessWidget {
  final String title;
  final Function onTap;
  final Duration eventDuration;
  final bool isDetailsPage;
  final bool isPrimary;
  final bool isPopular;
  final Color color;
  TitleRow({@required this.title, this.onTap, this.eventDuration, this.isDetailsPage, this.isPrimary=false, this.isPopular=false, this.color});

  @override
  Widget build(BuildContext context) {
    int days, hours, minutes, seconds;
    if (eventDuration != null) {
      days = eventDuration.inDays;
      hours = eventDuration.inHours - days * 24;
      minutes = eventDuration.inMinutes - (24 * days * 60) - (hours * 60);
      seconds = eventDuration.inSeconds - (24 * days * 60 * 60) - (hours * 60 * 60) - (minutes * 60);
    }

    return Row(children: [
      Text(title, style: robotoBold.copyWith(color: color != null? color: isPopular? Theme.of(context).cardColor : isPrimary? Theme.of(context).primaryColor : ColorResources.titleColor(context))),
      eventDuration == null
          ? Expanded(child: SizedBox.shrink())
          : Expanded(
              child: Row(children: [
              SizedBox(width: 5),
              TimerBox(time: days),
              Text(':', style: TextStyle(color: Theme.of(context).primaryColor)),
              TimerBox(time: hours),
              Text(':', style: TextStyle(color: Theme.of(context).primaryColor)),
              TimerBox(time: minutes),
              Text(':', style: TextStyle(color: Theme.of(context).primaryColor)),
              TimerBox(time: seconds, isBorder: true),
            ])),
      onTap != null
          ? InkWell(
              onTap: onTap,
              child: Row(children: [
                isDetailsPage == null ? Text(getTranslated('VIEW_ALL', context),
                        style: titilliumRegular.copyWith(
                          color: color != null? color: isPopular? Theme.of(context).cardColor : Theme.of(context).primaryColor,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                          decoration: TextDecoration.underline
                        ))
                    : SizedBox.shrink(),

              ]),
            )
          : SizedBox.shrink(),
    ]);
  }
}

class TimerBox extends StatelessWidget {
  final int time;
  final bool isBorder;

  TimerBox({@required this.time, this.isBorder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1),
      padding: EdgeInsets.all(isBorder ? 0 : 2),
      decoration: BoxDecoration(
        color: isBorder ? null : ColorResources.getPrimary(context),
        border: isBorder ? Border.all(width: 2, color: ColorResources.getPrimary(context)) : null,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Center(
        child: Text(time < 10 ? '0$time' : time.toString(),
          style: robotoBold.copyWith(
            color: isBorder ? ColorResources.getPrimary(context) : Theme.of(context).highlightColor,
            fontSize: Dimensions.FONT_SIZE_SMALL,
          ),
        ),
      ),
    );
  }
}
