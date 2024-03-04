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

    if (badgeID == 0 && badgeType == "Pending") {
      badgeName = "Pending";
      badgeColor = Colors.lightBlueAccent;
    } else if (badgeID == 1 && badgeType == "Bargaining") {
      badgeName = "Bargaining";
      badgeColor = Colors.amberAccent;
    } else if (badgeID == 2 && badgeType == "Host_Accepted") {
      badgeName = "Host Accepted";
      badgeColor = Colors.green;
    } else if (badgeID == 3 && badgeType == "Host_Rejected") {
      badgeName = "Host Rejected";
      badgeColor = Colors.red;
    } else if (badgeID == 4 && badgeType == "Guest_Accepted") {
      badgeName = "Guest Accepted";
      badgeColor = Colors.green;
    } else if (badgeID == 5 && badgeType == "Guest_Rejected") {
      badgeName = "Guest Rejected";
      badgeColor = Colors.red;
    } else if (badgeID == -1 && badgeType == "-") {
      badgeName = "";
      badgeColor = Colors.transparent;
    } else {
      badgeName = "";
      badgeColor = Colors.transparent;
    }

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