import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_simple_notes/src/cubit/authentication/authentication_cubit.dart';
import 'package:my_simple_notes/src/pages/signin_page.dart';
import 'package:my_simple_notes/src/pages/signup_page.dart';

class LaunchingPage extends StatefulWidget {
  const LaunchingPage({Key? key}) : super(key :key);
  @override
  State<LaunchingPage> createState() => _LaunchingPageState();
}

class _LaunchingPageState extends State<LaunchingPage> {

  @override
  Widget build(BuildContext context) {
    return   BlocProvider(
  create: (context) => AuthenticationCubit(),
  child: Scaffold(

      body:SingleChildScrollView(
        child:
        Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
              color: Colors.yellow.shade700
          ),

          child:
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex:5,



                  child: SingleChildScrollView(
                    child: Column(

                      children:[

                        Image(image: AssetImage('assets/logo.png')),

                      ],

                    ),
                  ),


                ),


                Expanded(
                  flex: 4,

                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade50,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50,right: 40),
                      child:
                      Column(

                          children: [
                            SizedBox(height: 40,),
                            Padding(
                              padding: const EdgeInsets.only(right: 200),
                              child: Text("Welcome",style: GoogleFonts.poppins(color: Colors.black,fontSize:21.0,fontWeight: FontWeight.w600),textAlign: TextAlign.left),
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.only(right:50 ),
                              child: Text("Notes are a great way to keep track of information for yourself.This app will let you save personal notes,contacts,and password as well as any other personal or secret information ",style:GoogleFonts.poppins (color: Colors.black,fontSize: 15.0,),textAlign: TextAlign.left,),
                            ),



                            SizedBox(height: 60,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                    child: Text(
                                        "    Sign In   ",
                                        style: GoogleFonts.poppins(fontSize: 20,color: Colors.white)
                                    ),
                                    style:  ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(22.0),
                                              //side: BorderSide(color: Colors.red)
                                            )
                                        )
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (_) => SignInPage()));
                                    }
                                ),
                                SizedBox(width: 50),

                                TextButton(
                                    child: Text(
                                        "    Sign Up   ",
                                        style: GoogleFonts.poppins(fontSize: 20,color: Colors.black)
                                    ),
                                    style:  ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(22.0),
                                              //side: BorderSide(color: Colors.red)
                                            )
                                        )
                                    ),
                                    onPressed: (){
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (_) => SignUpPage()));
                                    }

                                ),

                                SizedBox(height: 30,),


                              ],
                            ),
                            //  SizedBox(height: 30,),


                          ]
                      ),
                    ),
                  ),

                ),


              ]
          ),
        ),

      ),


    ),
);




  }



}
