import 'package:flutter/material.dart';
import 'package:vtech/util/const.dart';

List<Map> menuItems = [
  {
    'title': 'Account',
    'icon': Icons.account_circle_outlined,
  },
  {
    'title': 'Setting',
    'icon': Icons.settings,
  },
];

class MenuItem extends StatelessWidget {
  final String? title;
  final IconData? icon;

  MenuItem(
    { @required this.title, @required this.icon }
  );

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: new Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child:  Icon(
              icon,
              // Icons.bookmark_border,
              color: Constants.primary,
            ),
          ),
          Expanded(
            child: Container(
              // margin: EdgeInsets.only(right: 20.0),
              padding: EdgeInsets.symmetric(vertical: 13.0),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xfff0f0f0), width: 1.0 ))
              ),
              child: Text(
                title ?? '',
                style: TextStyle(color: Constants.primary)
              ),
            )
          )
        ],
      )
    );
  }
}

void showMainMenu (context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          color: Colors.white,
        ),
        child: new ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: menuItems.length,
          itemBuilder: (BuildContext context, int index) {
            print(menuItems[index]["title"]);
            return new MenuItem(
              title: "${menuItems[index]["title"]}",
              icon: menuItems[index]["icon"]
            );
          }
        ),
      );
    }
  );
}
