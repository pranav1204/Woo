import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woo/resources/auth_methods.dart';
import 'package:woo/screens/login_screen.dart';
import 'package:woo/utils/colors.dart';
import 'package:woo/utils/utils.dart';
import 'package:woo/widgets/text_filed_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  Uint8List? image;
  bool isloading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    bioController.dispose();
  }

  void selectImage() async{
  Uint8List im =  await pickImage(ImageSource.gallery);
  setState(() {
    image = im;
  });
  }

  void signUpUser() async {

    setState(() {
      isloading = true;
    });
      String res = await AuthMethods().signUpUser(
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
        bio: bioController.text,
        file: image!,
      );

      if(res != 'success'){
        showSnakBar(res, context);
      } else{
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Responsive_Layout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),
              ),
            ),
          );
      }


    setState(() {
      isloading = false;
    });
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                Image.asset(
                  "assets/Logo.png",
                  height: 64,
                ),
                const SizedBox(
                  height: 64,
                ),
                Stack(
                  children: [
                    image!=null?CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(image!),
                    ):
                    CircleAvatar(
                      radius: 64,
                      backgroundImage: AssetImage('assets/default_user.png'),
                    ),
                    Positioned(
                      bottom: -10,
                        left: 80,
                        child: IconButton(
                            onPressed: selectImage,
                            icon: Icon(Icons.camera_alt,size: 25,color: Colors.orange,),
                        ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 64,
                ),
                TextFiledInput(
                  textEditingController: usernameController,
                  hintText: 'Enter your username',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFiledInput(
                  textEditingController: emailController,
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFiledInput(
                  textEditingController: passwordController,
                  hintText: 'Enter your password',
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFiledInput(
                  textEditingController: bioController,
                  hintText: 'Enter your bio',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: signUpUser,
                  child: Container(
                    child: isloading? Center(child: CircularProgressIndicator(color: primaryColor,),): Text('Log in'),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      color: Colors.orange,
                    ),
                    // color: Colors.orange,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Flexible(
                  child: Container(),
                  flex: 2,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text('Already! have a account?'),
                      padding: EdgeInsets.symmetric(
                          vertical: 8
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: navigateToLogin,
                      child: Container(
                        child: Text('Log In.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 8
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
        ));
  }
}
