import 'package:flutter/material.dart';
import 'package:vtech/util/const.dart';

class AddCameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Camera'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),  
              child: Text(
                'Pair Camera on Mobile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Constants.primary
                ),
              ),
            ),
            Row(
              children: [
                Text('1. Press [Menu], select'),
                Icon(
                  Icons.menu,
                ), 
              ]
            ),
            Text(
              '> Connect Mobile Phone',
            ),
            SizedBox(height: 20),
            Text(
              '2. Follow instructions on the parent unit screen',
            ),
            SizedBox(height: 20),
            Text(
              '3. You will see Camera Pairing QR code on the parent unit',
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(15),
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade400)
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.9,
                heightFactor: 1,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xffebf1e9),
                    border: Border.all(color: Colors.grey.shade400)
                  ),
                  child: Text(
                    'Camera Pairing QR Code',
                    style: TextStyle(color: Constants.primary),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () { 
                        Navigator.pushNamed(context, '/scanQRCode');
                      },
                      child: const Text('See QR code on the parent unit'),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () { 
                      },
                      child: const Text('Cannot find the QR code'),
                    ),
                    SizedBox(height: 40)
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
