import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:dbdob/widgets/rounded_button.dart';
import 'package:dbdob/screens/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _formKey = GlobalKey<FormState>();

  var textValidator = MultiValidator([
    RequiredValidator(errorText: 'برجاء ادخال الرقم السري'),
  ]);

  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          'دخول',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Builder(
        builder: (context) => ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            Image.asset(
              'images/splash2.png',
              width: 100,
              height: 300,
            ),
            SizedBox(
              height: 40,
            ),
            Form(
              key: _formKey,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  textAlign: TextAlign.start,
                  obscureText: true,
                  validator: textValidator,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "ادخل الرقم السري",
                    labelText: "الرقم السري",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            RoundedButton(
                title: 'دخول',
                colour: Colors.teal,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (password == '123456') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    } else {
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        backgroundColor: Colors.black,
                        duration: Duration(seconds: 3),
                        content: Text(
                          "! كلمة السر غير صحيحة",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.end,
                        ),
                      ));
                    }
                  }
                })
          ],
        ),
      ),
    );
  }
}
