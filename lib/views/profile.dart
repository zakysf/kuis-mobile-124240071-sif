import 'package:flutter/material.dart';
import 'package:kuis/views/login.dart';
import 'package:kuis/models/data.dart';

class ProfilePage extends StatelessWidget {
  final Account account;
  const ProfilePage({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(20),
                // shape: BoxShape.circle,
                // border: Border.all(color: Colors.indigoAccent, width: 3),
                image: DecorationImage(
                  image: NetworkImage(
                    "https://img.freepik.com/premium-vector/profile-icon-logo-template-illustration-design-vector-eps-10_822766-6674.jpg", // url lengkap kamu
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Username", style: TextStyle(fontSize: 15)),
            SizedBox(height: 10),
            Text(
              account.username,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 5),
                  Text("Logout"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
