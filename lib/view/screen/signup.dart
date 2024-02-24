
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/bloc/authentication/authentication_event.dart';

import '../../../utill/color.dart';
import '../../../utill/globalmethod.dart';
import '../../bloc/main/bloc_event.dart';
import '../../data/repository/mainrepository.dart';
import '../../utill/app_constants.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';
import '../base/snackbar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.repository}) : super(key: key);
  final Repository repository;

  static Route<void> route(Repository repository) {
    return MaterialPageRoute<void>(builder: (_) => SignUpScreen(repository: repository,));
  }

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  String myAddress = "";
  bool passwordVisible = true;
  bool signUp = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: ColorResources.getBackgroundColor(context),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                child: Image.asset(Images.appLogo,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign Up", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.FONT_SIZE_OVER_LARGE, color: ColorResources.getBlackColor(context)),
                      ),
                      Text(
                        "Register Yourself Here.", style: TextStyle(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.getBlackColor(context)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                  decoration: BoxDecoration(
                      color: ColorResources.getWhiteColor(context),
                    borderRadius: BorderRadius.circular(20)
                  ),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: nameController,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          autofocus: false,
                          style: const TextStyle(color: ColorResources.blackCOLOR, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(color: ColorResources.blackCOLOR),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            errorText: validateFields(nameController.text, "Name", "Enter Name"),
                            hintText: "Name",
                            errorStyle: const TextStyle(color: ColorResources.redCOLOR),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  color: Colors.green,
                                  width: 2
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  color: ColorResources.blackCOLOR,
                                  width: 2
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                color: ColorResources.blackCOLOR,
                                width: 2.0,
                              ),
                            ),
                          ),
                          onChanged: (s) {
                            formKey.currentState!.validate();
                            setState(() {});
                          },
                          validator: (val){
                            return validateFields(nameController.text, "Name", "Enter Name");
                          },
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: emailController,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          autofocus: false,
                          style: const TextStyle(color: ColorResources.blackCOLOR, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(color: ColorResources.blackCOLOR),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            errorText: validateFields(emailController.text, "Email", "Enter Email"),
                            hintText: "Email",
                            errorStyle: const TextStyle(color: ColorResources.redCOLOR),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  color: Colors.green,
                                  width: 2
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  color: ColorResources.blackCOLOR,
                                  width: 2
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                color: ColorResources.blackCOLOR,
                                width: 2.0,
                              ),
                            ),
                          ),
                          onChanged: (s) {
                            formKey.currentState!.validate();
                            setState(() {});
                          },
                          validator: (val){
                            return validateFields(emailController.text, "Email", "Enter Email");
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordController,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          autofocus: false,
                          obscureText: passwordVisible,
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                            labelStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            labelText: "Password",
                            hintText: "Password",
                            errorText: validateFields(passwordController.text, "Password", "Enter Password"),
                            errorStyle: TextStyle(color: CustomColors.errorColor),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: CustomColors.greenButton,
                                  width: 2
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: CustomColors.textBlack,
                                  width: 2
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: CustomColors.textBlack,
                                width: 2.0,
                              ),
                            ),
                          ),
                          onChanged: (s) {
                            formKey.currentState!.validate();
                            setState(() {});
                          },
                          validator: (val){
                            return validateFields(passwordController.text, "Password", "Enter Password");
                          },
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if(formKey.currentState!.validate()){
                              setState(() {
                                signUp = true;
                              });
                              widget.repository.createUser(username: nameController.text, email: emailController.text, password: passwordController.text).then((value) async {
                                if(value == AppConstants.success){
                                  setState(() {
                                    signUp = false;
                                  });
                                  openMainEvent(context, const AuthenticationStatusChanged(MainBlocStatus.authenticated));
                                }else{
                                  setState(() {
                                    signUp = false;
                                  });
                                  showCustomSnackBar(value!, context);
                                }
                              });
                            }
                          },
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              padding:
                              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: CustomColors.greenButton),
                              child: signUp ? const CircularProgressIndicator(color: Colors.white,)  : Text(
                                "Submit",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: CustomColors.textBlack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                              )),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: (){
          openAuthenticationEvent(context, const LoginEvent());
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2.5,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromARGB(255, 50,53,82),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.login, color: ColorResources.whiteCOL0R,),
              Text(
                " Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.whiteCOL0R),
              ),
            ],
          ),
        ),
      ),
    );
  }

}