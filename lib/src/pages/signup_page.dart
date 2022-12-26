

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:my_simple_notes/src/pages/signin_page.dart';

import '../cubit/authentication/authentication_cubit.dart';
import '../helpers/data_validators.dart';
import '../models/user_model.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {


  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _nameController=TextEditingController();
  TextEditingController _mobileNoController=TextEditingController();
  bool isPasswordShown = false;
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: Scaffold(

        backgroundColor: Colors.yellow.shade700,
        body:  SingleChildScrollView(
            child: SizedBox(
              width: 400,
height: 1000,
              child:Container(

                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade700
                  ),

                  child:Padding(
                    padding: const EdgeInsets.only(left: 50,right: 50),
                    child: Column(
                        children: [
                          SizedBox(height: 120,),
                          Padding(
                            padding: const EdgeInsets.only(right: 210),
                            child: Text("Hi there!",style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                          ),
                          SizedBox(height: 40,),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                hintText: "Name",
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                fillColor: Colors.white),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: _emailController,
                            validator:DataValidator.isValidEmail ,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                hintText: "Email",
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                                fillColor: Colors.white),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                              controller: _passwordController,
                              validator: DataValidator.isValidPassword,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  suffixIcon: Visibility(visible: isPasswordShown,
                                    replacement: IconButton(
                                        onPressed: (){
                                          setState(() {
                                            isPasswordShown=!isPasswordShown;
                                          });
                                        },icon: Icon(Icons.visibility)),
                                    child:IconButton(
                                      onPressed: (){
                                        setState(() {
                                          isPasswordShown=!isPasswordShown;
                                        });
                                      }, icon: Icon(Icons.visibility_off),

                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  hintText: "Password",

                                  fillColor: Colors.white
                              ),
                              obscureText: !isPasswordShown

                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: _mobileNoController,
                            maxLength: 10,
                            validator: DataValidator.isValidMobile,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                hintText: "Mobile number",
                                prefixIcon: const Icon(
                                  Icons.call,
                                  color: Colors.grey,
                                ),
                                fillColor: Colors.white),
                          ),
                          SizedBox(height: 30,),
                          BlocConsumer<AuthenticationCubit,AuthenticationState>(
                            listener: (context, state) {
                              if(state is AuthenticationSuccess){
                                Navigator.of(context).push(MaterialPageRoute(builder:(_) =>HomePage()));
                              }else if(state is AuthenticationFailure){
                                String errorMessage =state.errorMessage;
                                showDialog(context: context,
                                    builder: (_,){
                                      return AlertDialog(
                                        title: Text("SignUp Failed"),
                                        content: Text("$errorMessage"),
                                        actions: [
                                          TextButton(onPressed: (){
                                            Navigator.pop(context);
                                          }, child: Text("ok"))
                                        ],
                                      );
                                    }
                                );
                              }

                            },
                            builder: (context, state) {
                              if (state is AuthenticationLoading){
                                return Lottie.asset('assets/lottie/loader.json');
                              }

                              return TextButton(
                                  child: Text(
                                      "    Sign Up   ",
                                      style: TextStyle(fontSize: 20,color: Colors.white)
                                  ),
                                  style:  ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),

                                          )
                                      )
                                  ),
                                  onPressed: () {
                                    UserModel userModel = UserModel(email: _emailController.text,
                                        name: _nameController.text,
                                        password: _passwordController.text,
                                        mobileNo: _mobileNoController.text);
                                    context.read<AuthenticationCubit>().createUser(userModel);


                                  }
                              );
                            },
                          ),
                          SizedBox(height: 50,),
                          Padding(
                            padding: const EdgeInsets.only(right: 180),
                            child: Text("Already a member?",style: TextStyle(color: Colors.white,fontSize: 12.0,)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) => SignInPage()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 230),
                              child: Text("Sign In",style: TextStyle(color: Colors.black,fontSize: 12.0,decoration: TextDecoration.underline)),
                            ),)
                        ]
                    ),
                  )

              ),
            )
        ),
      ),
    );
  }
}