import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';




Container newAvatar(String avatarName,double radiusnum,double hintnum,BuildContext context,String routeName){
var userAvartar = Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: CircularProfileAvatar(
        radius: 100,
        backgroundColor: Colors.purple,
        borderWidth: 0,
        initialsText: Text(
          avatarName.substring(0, 1),
          style: TextStyle(fontSize: hintnum, color: Colors.white),
        ),
        borderColor: Colors.brown,
        elevation: 0.0,
        foregroundColor: Colors.purple[400],
        cacheImage: true,
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        showInitialTextAbovePicture: true,
        imageUrl: 'https://static.haha.mx/images/topic_default.png',
      ),
      width:radiusnum,
      height: radiusnum,
    );
    return userAvartar;
}
