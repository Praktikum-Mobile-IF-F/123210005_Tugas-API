import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_api/view/login_page.dart';

class RegisterPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register", style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextField(
                controller: dobController,
                decoration: InputDecoration(labelText: 'Date of Birth'),
              ),
              SizedBox(height: 16,),
              ElevatedButton(
                onPressed: () async {
                  if (!emailController.text.isEmpty || !passwordController.text.isEmpty) {
                    // Simpan data user menggunakan Shared Preferences
                    SharedPreferences logindata = await SharedPreferences.getInstance();
                    logindata.setString('email', emailController.text);
                    logindata.setString('password', passwordController.text);
                    logindata.setString('dob', dobController.text);

                    // Pindah ke halaman Home
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  } else {
                    const snackBar = SnackBar(
                      content: Text('Silakan masukkan data dengan benar dan lengkap'),
                      duration: Duration(seconds: 1),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                },
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.black
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
