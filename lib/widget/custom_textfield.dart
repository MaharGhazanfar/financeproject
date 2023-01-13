import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomWidget {
  static Widget customTextFormField({
    required TextEditingController controller,
    void Function(String)? onChanged,
    bool obscureText = false,
    required String titleName,
    String? hintText,
    bool readOnly = false,
    Widget? suffix,
    Color styleColor = Colors.white,
    FormFieldValidator<String?>? validate,
    TextInputType textInputType = TextInputType.text,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      style: TextStyle(color: styleColor),
      validator: validate,
      readOnly: readOnly,
      maxLength: maxLength,
      keyboardType: textInputType,
      decoration: InputDecoration(
        // constraints: BoxConstraints(maxHeight: 50),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        hintText: hintText,
        suffix: suffix,
        counterStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),
        label: Text(
          titleName,
          style: TextStyle(color: styleColor),
        ),
      ),
    );
  }

  static Widget customTextField(
      {required TextEditingController controller,
      required IconData icon,
      required String titleName,
      required FormFieldValidator<String>? validate,
      TextInputType textInputType = TextInputType.text,
      int? maxLength,
      List<TextInputFormatter>? inputFormatters,
      String? prefixText}) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: [
        BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            offset: const Offset(
              0.5,
              0.5,
            ),
            spreadRadius: 1,
            blurRadius: 3)
      ]),
      child: TextFormField(
        controller: controller,
        inputFormatters: inputFormatters,
        validator: validate,
        keyboardType: textInputType,
        maxLength: maxLength,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            filled: true,
            prefixText: prefixText,
            prefixIconColor: Colors.red,
            prefixIcon: Icon(
              icon,
              color: Colors.black,
            ),
            label: Text(titleName),
            labelStyle: const TextStyle(color: Colors.black),
            fillColor: Colors.white,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 1)),
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }

  static Widget customRow({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.white)),
        ],
      ),
    );
  }
}
