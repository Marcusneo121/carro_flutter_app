import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final int badgeID;
  final String badgeType;

  const StatusBadge({
    super.key,
    required this.badgeID,
    required this.badgeType,
  });

  @override
  Widget build(BuildContext context) {
    String? badgeName;
    Color? badgeColor;

    switch (badgeID) {
      case 0:
        badgeName = "Pending";
        badgeColor = Colors.lightBlueAccent;
        break;
      case 1:
        badgeName = "Bargaining";
        badgeColor = Colors.amberAccent;
        break;
      case 2:
        badgeName = "Host Accepted";
        badgeColor = Colors.green;
        break;
      case 3:
        badgeName = "Host Rejected";
        badgeColor = Colors.red;
        break;
      case 4:
        badgeName = "Guest Accepted";
        badgeColor = Colors.green;
        break;
      case 5:
        badgeName = "Guest Rejected";
        badgeColor = Colors.red;
        break;
      case 6:
        badgeName = "Booking Paid";
        badgeColor = Colors.green;
        break;
      case 7:
        badgeName = "Pending Payment";
        badgeColor = Colors.blue;
        break;
      case -1:
        badgeName = "";
        badgeColor = Colors.transparent;
        break;
      default:
        badgeName = "";
        badgeColor = Colors.transparent;
        break;
    }

    // if (badgeID == 0 && badgeType == "Pending") {
    //   badgeName = "Pending";
    //   badgeColor = Colors.lightBlueAccent;
    // } else if (badgeID == 1 && badgeType == "Bargaining") {
    //   badgeName = "Bargaining";
    //   badgeColor = Colors.amberAccent;
    // } else if (badgeID == 2 && badgeType == "Host_Accepted") {
    //   badgeName = "Host Accepted";
    //   badgeColor = Colors.green;
    // } else if (badgeID == 3 && badgeType == "Host_Rejected") {
    //   badgeName = "Host Rejected";
    //   badgeColor = Colors.red;
    // } else if (badgeID == 4 && badgeType == "Guest_Accepted") {
    //   badgeName = "Guest Accepted";
    //   badgeColor = Colors.green;
    // } else if (badgeID == 5 && badgeType == "Guest_Rejected") {
    //   badgeName = "Guest Rejected";
    //   badgeColor = Colors.red;
    // } else if (badgeID == 6 && badgeType == "Booking_Paid") {
    //   badgeName = "Booking Paid";
    //   badgeColor = Colors.green;
    // } else if (badgeID == 7 && badgeType == "Payment_Pending") {
    //   badgeName = "Pending Payment";
    //   badgeColor = Colors.blue;
    // } else if (badgeID == -1 && badgeType == "-") {
    //   badgeName = "";
    //   badgeColor = Colors.transparent;
    // } else {
    //   badgeName = "";
    //   badgeColor = Colors.transparent;
    // }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: badgeColor),
      ),
      child: Text(
        badgeName.toString(),
        style: CarroTextStyles.medium_item_text.copyWith(
          color: badgeColor,
        ),
      ),
    );
  }
}

// 0	Pending
// 1	Bargaining
// 2	Host_Accepted
// 3	Host_Rejected
// 4	Guest_Accepted
// 5	Guest_Rejected