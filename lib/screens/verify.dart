import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtech/util/const.dart';
import '../blocs/blocs.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  
  final codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
    Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton (
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Constants.secondary,
            ), 
            onPressed: () {
              authBloc.add(UserSignInReset());
            },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                hintText: 'Verification Code'
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () { 
                authBloc.add(UserVerifyStart(code: codeController.text));
              },
              child: const Text('Verify'),
            ),
          ]
        )
      )
    );
  }
}

