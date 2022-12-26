
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:my_simple_notes/src/pages/signup_page.dart';

import '../cubit/authentication/authentication_cubit.dart';
import 'home_page.dart';
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  bool isPasswordShown = false;
  @override
  Widget build(BuildContext context) {
    return   BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: Scaffold(

        backgroundColor: Colors.yellow.shade700,
        body:  SingleChildScrollView(
            child: SizedBox(
              width: 400,

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
                    child: Form(
                      child: Column(
                          children: [
                            SizedBox(height: 120,),
                            Padding(
                              padding: const EdgeInsets.only(right: 150),
                              child: Text("Welcome back!",style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                            ),
                            SizedBox(height: 40,),


                            TextFormField(
                              controller: _emailController,

                              autovalidateMode:     AutovalidateMode.onUserInteraction,
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
                            SizedBox(height: 30,),
                            TextFormField(
                                controller: _passwordController,

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
                                  hintText: "      Password",

                                  fillColor: Colors.white,

                                ),
                                obscureText: !isPasswordShown
                            ),


                            SizedBox(height: 40,),
                            BlocConsumer<AuthenticationCubit, AuthenticationState>(
                              listener: (context, state) {
                                if (state is AuthenticationSuccess) {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) => HomePage()));
                                }else if(state is AuthenticationFailure){
                                  String errorMessage =state.errorMessage;
                                  showDialog(context: context,
                                      builder: (_,){
                                        return AlertDialog(
                                          title: Text("Login Failed"),
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
                                  return  Lottie.asset('assets/lottie/loader.json');
                                }

                                return TextButton(
                                    child: Text(
                                        "    Sign In   ",
                                        style: GoogleFonts.poppins(fontSize: 20,color: Colors.white)
                                    ),
                                    style:  ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(22.0),

                                            )
                                        )
                                    ),
                                    onPressed: () {
                                      context.read<AuthenticationCubit>().loginUser(
                                          _emailController.text, _passwordController.text);

                                    }
                                );
                              },
                            ),
                            SizedBox(height: 100,),
                            Padding(
                              padding: const EdgeInsets.only(right: 200),
                              child: Text("New member?",style: TextStyle(color: Colors.white,fontSize: 12.0,)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => SignUpPage()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 230),
                                child: Text("Sign Up",style: TextStyle(color: Colors.black,fontSize: 12.0,decoration: TextDecoration.underline)),
                              ),)
                          ]
                      ),
                    ),
                  )

              ),
            )
        ),

      ),
    );
  }
}
