
// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live_edu/app_constants/edu_Icons.dart';
import 'package:live_edu/app_constants/edu_colors.dart';
import '../utils/page_button.dart';

enum AuthMode{login , signUp}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  var _authMode = AuthMode.login;

  //*variables
  var _enterdemail = '';
  var _enterdPassword = '';

    //*Controllers
  final TextEditingController phoneCtrl=TextEditingController();
  final TextEditingController emailCtrl=TextEditingController();
  final TextEditingController passwordCtrl=TextEditingController();
  final TextEditingController nameCtrl =TextEditingController();

  //*FocusNodes 
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  
  //*bool value to controll the visiblity of password
  bool hidePassword = true;

  //*Login user
  void _login() async{

    //*loading indicator
    showDialog(context: context, builder: (context){
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

    //*loging user in
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _enterdemail, password: _enterdPassword);
  } on FirebaseAuthException catch(e){
   Navigator.of(context).pop();
  if(e.code == 'user-not-found'){
  return showSnackBar(context, 'No user found for that email');
  } else if (e.code == 'wrong-password') {
    return showSnackBar(context, 'Incorrect password');
    }
  }
    //* poping out the loading indicator once we  have user credentials
    Navigator.of(context).pop();
  }


  //*Register or create a new user
  void _createUser() async{

    //*loading indicator
    showDialog(context: context, builder: (context){
      return const Center(
        child: CircularProgressIndicator(),
      );
    });


  //*creating a new user
   try {
   await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _enterdemail,
    password: _enterdPassword,
  );
} on FirebaseAuthException catch (e) {
  Navigator.of(context).pop();
  if (e.code == 'weak-password') {
     return showSnackBar(context, 'Password is too weak');
  } else if (e.code == 'email-already-in-use') {
    return showSnackBar(context, 'Email is already registerd');
  }
} catch (e) {
 return showSnackBar(context, '$e');
}

//* poping out the loading indicator once we  have user credentials
    Navigator.of(context).pop();
 }

//*Saving form
   void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if(_authMode == AuthMode.login){
        _login();
      }else{
        _createUser();
      }
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EduColors.backgroundColor, 
      body: SafeArea(child: GestureDetector(
        onTap: () {
          _emailFocusNode.unfocus();
          _passwordFocusNode.unfocus();
          _nameFocusNode.unfocus();
          _phoneFocusNode.unfocus();
          setState(() {});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _authMode == AuthMode.signUp ?
             Padding(
              padding:  const EdgeInsets.only(left:18.0,top: 8),
              child: GestureDetector(
                onTap: () {
                  emailCtrl.clear();
                  passwordCtrl.clear();
                  _emailFocusNode.unfocus();
                  _passwordFocusNode.unfocus();
                  _formKey.currentState?.reset();
                  _authMode = AuthMode.login; 
                  setState(() {
                  });
                },
                child: const Icon(EduIcons.back,size: 30,)),
            ) : const SizedBox(),
          SizedBox(height: _authMode == AuthMode.login ? MediaQuery.of(context).size.height*0.09 : MediaQuery.of(context).size.height*0.04 ),
           Expanded(
             child: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                _authMode == AuthMode.login ? const Padding(
                padding:  EdgeInsets.only(left:30.0),
                child: Text('Welcome back' ,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                     ) : 
                     const Padding(
                         padding:  EdgeInsets.only(left:30.0),
                child:  Text('Create new account' ,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                     ) ,
                       _authMode == AuthMode.login ?
                     const Padding(
                padding:  EdgeInsets.only(left:30.0,top:6.0),
                child: SizedBox(
                  width: 250,
                  child:  Text('sign in to an existing account using your phone number',style: TextStyle(fontSize: 16,))),
                     ) : const Padding(
                padding:  EdgeInsets.only(left:30.0,top:6.0),
                child: SizedBox(
                  width: 300,
                  child:  Text('Create a new account by filling all the fields or login to an existing account ',style: TextStyle(fontSize: 16,))),
                     ) ,
                     SizedBox(height: MediaQuery.of(context).size.height*0.05),
                     Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
      
                //*Form with TextFormFields
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _authMode == AuthMode.signUp ? 
                      //*Name Field
                      Padding(
                        padding: const EdgeInsets.only(bottom:20.0),
                        child: TextFormField(
                          controller: nameCtrl,
                          focusNode: _nameFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_emailFocusNode);
                          },
                          inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),], // Only allow alphabetic characters
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return "Please enter name";
                            }
                            return null;
                          },
                          maxLength: 45,
                          decoration: InputDecoration(
                            counterText: '',
                            fillColor: const Color(0xFFBFC3FC).withOpacity(0.3),
                            hoverColor: const Color(0xFFA2C3FC),
                            hintText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                            )
                          ),
                        ),
                      ) : const SizedBox(),
      
                      //*Email Field
                       Padding(
                        padding: const EdgeInsets.only(bottom:20.0),
                         child: TextFormField(
                          controller: emailCtrl,
                          onFieldSubmitted: _authMode == AuthMode.login ?  (_) {
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                          } :(_) { 
                            FocusScope.of(context).requestFocus(_phoneFocusNode);
                          },
                           onSaved: (newValue) {
                            _enterdemail = newValue!;
                          },
                          // initialValue: _enterdemail,
                          focusNode: _emailFocusNode, 
                         validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter an email";
                          } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
                            return "Please enter a valid email";
                            }
                            return null; // Return null if the email is valid
                        },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            fillColor: const Color(0xFFBFC3FC).withOpacity(0.3),
                            hoverColor: const Color(0xFFA2C3FC),
                            hintText: 'Email',
                            
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                            )
                          ),
                                         ),
                       ),
      
                      _authMode == AuthMode.signUp ?  
      
                      //*Phone number Field
                      Padding(
                      padding: const EdgeInsets.only(bottom:20.0),
                        child: TextFormField(
                          controller: phoneCtrl,
                          focusNode: _phoneFocusNode, 
                          onFieldSubmitted: (_) { 
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return "Please Enter phone number";
                            }else if(value.length != 10){
                              return "Please enter valid phone number";
                            }
                            return null; //Return null if number is valid 
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            fillColor: const Color(0xFFBFC3FC).withOpacity(0.3),
                            hoverColor: const Color(0xFFA2C3FC),
                            hintText: 'Phone',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                            )
                          ),
                        ),
                      ) : const SizedBox(),
      
                     //*Password Field
                       TextFormField(
                        controller: passwordCtrl,
                        focusNode: _passwordFocusNode,
                        // initialValue: _enterdPassword,
                        onSaved: (newValue) {
                          _enterdPassword = newValue!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a password";
                          } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*])[A-Za-z\d!@#\$%^&*]{8,}$').hasMatch(value)) {
                            return "Please enter a valid password";
                            }
                            return null; // Return null if the password is valid
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _authMode == AuthMode.login ? hidePassword : false,
                        decoration: InputDecoration(
                          fillColor: const Color(0xFFBFC3FC).withOpacity(0.3),
                          hoverColor: const Color(0xFFA2C3FC),
                          hintText: 'Password',
                          suffixIcon: _authMode == AuthMode.login ? GestureDetector(
                            onTap: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            child: hidePassword ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility) ) : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          )
                        ), 
                      ),
                   ] ),
                  ),)
                     ]),
              ),
                   ),
           ),
          Center(child: PageButton(buttonTap: () {
            _saveForm();
            // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => HomeScreen()));
          },buttonText: _authMode == AuthMode.login ? 'Login' : 'Create',),),
          _authMode == AuthMode.login ?
          Padding(
            padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
            child: Center(child: RichText(
          text: TextSpan(
        text: 'Don\'t have an account?', style: const TextStyle(color: Colors.black, fontSize: 18),children: <TextSpan>[
        TextSpan(text: ' Sign up', style: const TextStyle(color: Colors.blueAccent, fontSize: 18),recognizer: TapGestureRecognizer(
      
        )..onTap =() {
          emailCtrl.clear();
          passwordCtrl.clear();
          _emailFocusNode.unfocus();
          _passwordFocusNode.unfocus();
           _formKey.currentState?.reset();
          _authMode = AuthMode.signUp;
          setState(() {});
        }
        )
      ]),
          ))) : const SizedBox(height: 12,)
        ],),
      )),
    );
  }

   //*snackbar
  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Center(child: Text(message, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w400),)),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.none,
      margin: const EdgeInsets.only(bottom:110, top: 0,right: 50, left: 50),
      elevation: 3,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: const Duration(milliseconds: 2000),
      
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
