import 'package:flutter/material.dart';

PreferredSizeWidget appBarMain(BuildContext context){
  return AppBar(
    title: Text(
      "UpTalks",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
    centerTitle: true,
    elevation: 10,
  );
}