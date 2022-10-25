import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:task_project/utils/colors.dart';
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
          messageText.length > 25
              ? Expanded(child: getTextContainer(text: messageText))
              : getTextContainer(text: messageText),
          const SizedBox(width: 10),
          Text(
            dateText,
            style: const TextStyle(
              color: MyColors.C_888888,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Container getTextContainer({required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
      decoration: const BoxDecoration(
        color: MyColors.C_C4385F5,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Linkify(
        style: const TextStyle(fontSize: 14, color: Colors.white),
        linkStyle: const TextStyle(fontSize: 14, color: Colors.amber),
        textAlign: TextAlign.left,
        onOpen: (link) async {
          var response = await MyUtils.onUrlOpen(link);
          if (response == false) {
            MyUtils.getUrlOpenFailToast();
          }
        },
        text: text,
      ),
    );
  }
}
