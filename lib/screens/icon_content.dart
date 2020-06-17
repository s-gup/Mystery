import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class IconContents extends StatelessWidget {
  IconContents({this.icon, this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            size: 80,
          ),
          SizedBox(height: 15),
          Text(
            label,
            style: kLabelTestStyle,
          )
        ],
      ),
    );
  }
}
