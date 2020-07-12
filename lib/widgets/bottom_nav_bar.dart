import 'package:flutter/material.dart';

import 'package:meditation_app/constants.dart';

class BottomNavBar extends StatelessWidget {
  final String whichScreen;
  const BottomNavBar({
    Key key,
    this.whichScreen
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavItem(
            title: "Today",
            isActive: whichScreen=='today'?true:false,
            mIcon: Icons.table_chart,
            press: (){
              Navigator.pushNamed(context, '/today');
            },
          ),
          BottomNavItem(
            title: "All Exercises",
               isActive: whichScreen=='home'?true:false,
            mIcon: Icons.home,
          
            press: (){
              Navigator.pushReplacementNamed(context,'/home');
            },
          ),
          BottomNavItem(
            title: "Settings",
               isActive: whichScreen=='settings'?true:false,
            mIcon: Icons.settings,
            press: (){
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData mIcon;
  final String title;
  final Function press;
  final bool isActive;
  const BottomNavItem({
    Key key,
    this.mIcon,
    this.title,
    this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.purpleAccent,
        onTap: press,
        child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
       Icon(mIcon,color: isActive ? Colors.purple : Colors.grey),
      //SvgPicture.asset(
      //   svgScr,
      //   color: isActive ? kActiveIconColor : kTextColor,
      // ),
      Text(
        title,
        style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
      ),
    ],
        ),
      );
  }
}
