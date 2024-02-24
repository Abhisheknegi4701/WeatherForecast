
import 'package:flutter/material.dart';

import '../../utill/color.dart';
import '../../utill/globalmethod.dart';

editText(BuildContext context, GlobalKey<FormState> formKey, TextEditingController controller, String hint, String error, TextInputType type, int lineLength, bool validate, bool filled) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      maxLines: lineLength,
      obscureText: hint == "Password" ? true: false,
      autofocus: false,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        errorText: validate ? validateFields(controller.text, hint, error) : controller.text.isNotEmpty?
        validateFields(controller.text, hint, error): null,
        labelText: hint,
        hintText: hint,
        errorStyle: TextStyle(color: CustomColors.errorColor),
        /* hintStyle: const TextStyle(color: Colors.black),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.black,*/
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
        if(validate){
          formKey.currentState!.validate();
          if(controller.text.isNotEmpty){
            filled = true;
          }
        }
      },
      keyboardType: type,
      validator: (val){
        if(validate || controller.text.isNotEmpty){
          return validateFields(val!, hint, error);
        }
        return null;
      },
    ),
  );
}