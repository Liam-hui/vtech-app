import 'package:flutter/material.dart';
import 'package:vtech/util/const.dart';
import 'package:vtech/widgets/cameraStream.dart';
import 'package:vtech/widgets/mainMenu.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton (
          icon: Icon(
            Icons.menu,
          ), 
          onPressed: () {
            showMainMenu(context);
          },
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                showCameraMenu(context);
              },
              child: Icon(
                Icons.add,
                color: Constants.primary
              ),
            )
          ),  
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Cam 1',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.width * 9 / 16,
            height: MediaQuery.of(context).size.width * 0.5,
            // decoration: BoxDecoration(
              // color: Colors.red
            // ),
            child: CameraStream(),
          ),
        ]
      )
    );
  }
}

void showCameraMenu (context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {

      final items = <Widget>[SizedBox(width: 7)];
      for (int i = 0; i < 1; i++) {
        items.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/addCamera');
              },
              child: Column(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Constants.primary
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    'Add\nCamera',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Constants.primary,
                      fontSize: 13
                    ),
                  ),
                ],
              )
            )
          )
        );
      }

      return Container(
        padding: EdgeInsets.only(top: 15, bottom: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          color: Colors.white,
        ),
        child: UnconstrainedBox(
          constrainedAxis: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Select Camera',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Constants.primary
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: items),
              ),
            ]
          )
        )
      );
    }
  );
}
