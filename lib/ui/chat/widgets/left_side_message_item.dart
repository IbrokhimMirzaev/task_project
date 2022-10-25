import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:task_project/utils/my_utils.dart';

class LeftSideMessageItem extends StatelessWidget {
  const LeftSideMessageItem({
    Key? key,
    required this.dateText,
    required this.messageText,
  }) : super(key: key);

  final String dateText;
  final String messageText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // messageText.length > 25
          const SizedBox(width: 10),
          Text(
            dateText,
            style: const TextStyle(
              color: Color(0xffc888888),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
