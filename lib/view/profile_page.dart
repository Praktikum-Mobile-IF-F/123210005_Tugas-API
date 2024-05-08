import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String email = '';
  String dob = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    SharedPreferences logindata = await SharedPreferences.getInstance();
    setState(() {
      email = logindata.getString('email') ?? '';
      dob = logindata.getString('dob') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Table(
                defaultColumnWidth: FixedColumnWidth(150),
                children: [
              TableRow(
                  children: [
                    TableCell(child: Text("Email")),
                    TableCell(child: Text(email))
                  ] 
              ),
              TableRow(
                children: [
                  TableCell(child: Text('Date of Birth')),
                  TableCell(child: Text(dob)),
                ],
              )
            ]),
          ),
        ));
  }
}
