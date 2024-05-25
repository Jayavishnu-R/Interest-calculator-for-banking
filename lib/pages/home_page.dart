import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modern_login/pages/fd.dart';
import 'package:modern_login/pages/loan.dart';
//import 'package:modern_login/pages/loan2.dart';
import 'package:modern_login/pages/rd2.dart';
import 'package:modern_login/pages/Loan3.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logged in as :${user.email!}"),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SIForm(),
                    ));
                // Action for Button 1
                // buttonClicked(1);
              },
              child: Text('FD'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RDFORM(),
                    ));
                // Action for Button 2
                // buttonClicked(2);
              },
              child: Text('RD'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Loan(),
                    ));
                // Action for Button 3
                // buttonClicked(3);
              },
              child: Text('LOAN'),
            ),
          ],
        ),
      ),
    );
  }
}
