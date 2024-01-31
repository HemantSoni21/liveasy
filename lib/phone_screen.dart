import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:hemant_task/otp_screen.dart';
import 'package:hemant_task/state.dart';
import 'package:provider/provider.dart';

class PhoneScreen extends StatelessWidget {
  static const routeName = 'phonescreen';
  final _key = GlobalKey<FormState>();
  String verify = '';

  Widget build(BuildContext context) {
    final dataState = Provider.of<DataState>(context);
    onSubmit() async {
      final validate = _key.currentState!.validate();
      if (!validate) {
        return;
      }

      await FirebaseAuth.instance
          .verifyPhoneNumber(
        phoneNumber: '+91${dataState.phoneNumber}',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          verify = verificationId;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return OtpScreen(verify);
          }));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      )
          .onError((error, stackTrace) {
        dataState.isOTPScreenLoading = false;
        dataState.notifyListeners();
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Please enter your mobile number',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'You\'ll receive a 4 digit code\n to verify next.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            SizedBox(
              height: 25,
            ),
            Form(
                key: _key,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/Flag_of_India.png',
                        scale: 45,
                      ),
                      Text(
                        '   +91 -  ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.length < 10) {
                              return 'Invalid input: number contains 10 digits';
                            }
                          },
                          onChanged: (value) =>
                              dataState.phoneNumber = int.parse(value),
                          onSaved: (newValue) =>
                              dataState.phoneNumber = int.parse(newValue!),
                          onFieldSubmitted: (value) {
                            dataState..phoneNumber = int.parse(value);
                          },
                          decoration: InputDecoration(
                              hintText: 'Mobile Number',
                              hintStyle: TextStyle(fontSize: 19),
                              counterText: '',
                              border: InputBorder.none),
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(color: Color.fromARGB(255, 46, 59, 98)),
              child: InkWell(
                onTap: () {
                  dataState.isPhoneScreenLoading = true;
                  dataState.notifyListeners();
                  onSubmit();
                },
                child: dataState.isPhoneScreenLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                    : Center(
                        child: Text(
                          'CONTINUE',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
