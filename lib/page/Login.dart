
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client/api/my_api.dart';
import 'package:flutter_client/widgets/Button/myButton.dart';
import 'package:flutter_client/widgets/Other/ErrorAlertDialog.dart';
import 'package:flutter_client/widgets/TextInput/myTextInput.dart';
import 'package:flutter_client/globals/globals.dart' as globals;

Color colEmail = Colors.blue.shade50;               //email
Color colEmail_1 = Colors.blue.shade900;
Color colEmail_2 = Colors.blue.shade900.withOpacity(0.5);


Color colPass = Colors.blue.shade50;               //password
Color colPass_1 = Colors.blue.shade900;
Color colPass_2 = Colors.blue.shade900.withOpacity(0.5);


class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text("Login",style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.black
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.account_circle,size: 120.0,),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: myTextInput(textString: "Enter Your Email Address",
                      labelText: 'Enter Your Email Address',
                      colBlue: colEmail,
                      colBlue_1: colEmail_1,
                      colBlue_2: colEmail_2,
                      obscure: false ,
                      onChange: (value){
                        globals.emailLogin = value;
                      }),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: myTextInput(
                    textString: "Enter Your Password",
                    labelText: 'Enter Your Password',
                    colBlue: colPass,
                    colBlue_1: colPass_1,
                    colBlue_2: colPass_2,
                    obscure: true,
                    onChange: (value){
                      globals.passwordLogin = value;
                      //print(globals.passwordLogin);
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    child: btn(btnText: "Submit"),
                    onTap: (){
                      try {
                        _LoginCtrl();
                      }catch(e){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => ErrorAlertDialog(
                                message: globals.errorException));
                      }
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("didn't have an account? "),
                      Row(
                        children: [
                          InkWell(
                            child: Text("create new one",style: TextStyle(
                                color: Colors.blue
                            ),),
                            onTap: (){
                              Navigator.pushNamed(context, '/Registration');
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


  _LoginCtrl(){
    bool if1 = false;
    bool if2 = false;

    if(globals.emailLogin != null){
      if(globals.emailLogin!.isNotEmpty)
        if1 = true;
    }

    if(globals.passwordLogin != null){
      if(globals.passwordLogin!.isNotEmpty)
        if2 = true;
    }

    if(if1){
      setState(() {
        colEmail = Colors.blue.shade50;
        colEmail_1 = Colors.blue.shade900;
        colEmail_2 = Colors.blue.shade900.withOpacity(0.5);
      });
    }else{
      setState(() {
        colEmail = Colors.red.shade50;
        colEmail_1 = Colors.red.shade900;
        colEmail_2 = Colors.red.shade900.withOpacity(0.5);
      });
    }


    if(if2){
      setState(() {
        colPass = Colors.blue.shade50;
        colPass_1 = Colors.blue.shade900;
        colPass_2 = Colors.blue.shade900.withOpacity(0.5);
      });
    }else{
      setState(() {
        colPass = Colors.red.shade50;
        colPass_1 = Colors.red.shade900;
        colPass_2 = Colors.red.shade900.withOpacity(0.5);
      });
    }


    if(if1 && if2){
      _verifc();
    }else{
      showDialog(
          context: context,
          builder: (BuildContext context) => ErrorAlertDialog(
              message: globals.error7));
    }


  }



  _verifc() async{


    if(globals.emailLogin != null && globals.passwordLogin != null){
      // print(globals.emailLogin);
      // print(globals.passwordLogin);
      var data = {
        'email': globals.emailLogin,
        'password': globals.passwordLogin
      };

      var res = await CallApi().postData(data, 'Login/Control/(Control)Login.php');
      print(res);
      print(res.body);
      List<dynamic> body = json.decode(res.body);

      if(body[0] == "success"){
        Navigator.pushNamed(context, '/home');
      }else if(body[0] == "error8"){
        colEmail = Colors.red.shade50;
        colEmail_1 = Colors.red.shade900;
        colEmail_2 = Colors.red.shade900.withOpacity(0.5);
        colPass = Colors.red.shade50;
        colPass_1 = Colors.red.shade900;
        colPass_2 = Colors.red.shade900.withOpacity(0.5);
        showDialog(
            context: context,
            builder: (BuildContext context) => ErrorAlertDialog(
                message: globals.error8));
      }
    }else{

    }
  }
}