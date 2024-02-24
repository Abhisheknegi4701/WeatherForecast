
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/bloc/authentication/authentication_event.dart';
import 'package:weather/data/repository/mainrepository.dart';
import 'package:weather/utill/app_constants.dart';

import '../../../utill/color.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/globalmethod.dart';
import '../../../utill/images.dart';
import '../../bloc/main/bloc_event.dart';
import '../base/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.repository});
  final Repository repository;

  static Route<void> route(Repository repository) {
    return MaterialPageRoute<void>(builder: (_) => LoginScreen(repository: repository,));
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool middleTitle = true;
  bool floatingButton = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = true;
  bool login = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: ColorResources.getBackgroundColor(context),
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
                        "Login", style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                          color: ColorResources.getBlackColor(context)),

                      ),
                      Text(
                        "Try Login Here.", style: TextStyle(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.getBlackColor(context)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 6,
                          child: const Divider(
                            thickness: 5,
                            color: ColorResources.borderCOLOR,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
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
                          height: 20,
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
                            hintText: "password",
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
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if(formKey.currentState!.validate()){
                              setState(() {
                                login = true;
                              });
                              widget.repository.logIn(username: emailController.text, password: passwordController.text).then((value) async {
                                if(value == AppConstants.success){
                                  setState(() {
                                    login = false;
                                  });
                                  openMainEvent(context, const AuthenticationStatusChanged(MainBlocStatus.authenticated));
                                }else{
                                  setState(() {
                                    login = false;
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
                              child: login ? const CircularProgressIndicator(color: Colors.white,)  : Text(
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
          openAuthenticationEvent(context, const SignUpEvent());
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width / 2.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromARGB(255, 50,53,82),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.app_registration, color: ColorResources.whiteCOL0R,),
              Text(
                " SignUp", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.whiteCOL0R),
              ),
            ],
          ),
        ),
      ),
    );
  }
}