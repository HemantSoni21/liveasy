import 'package:flutter/material.dart';
import 'package:hemant_task/state.dart';
import 'package:provider/provider.dart';

class FinalScreen extends StatelessWidget {
  static const routeName = 'finalScreen';
  final List<String> languages = ['English', 'Hindi'];
  Widget build(BuildContext context) {
    final dataState = Provider.of<DataState>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Thank You!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Language: ${languages[dataState.language!].toString()}'),
            Text(('Phone Number: ${dataState.phoneNumber} (verified)')),
            Text('Profile: ${dataState.isShipper ? 'Shipper' : 'Transporter'}')
          ],
        ),
      ),
    );
  }
}
