import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(
      {required String hintText,
      required Widget widget,
      required isWidgetRequired}) {
    return InputDecoration(
      fillColor: Colors.black,
      focusColor:Colors.grey.shade300,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade400, width: 1.0)),
      // UnderlineInputBorder(
      //    borderSide: BorderSide(color: Colors.redAccent, width: 2.0)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color:Colors.grey.shade300,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      // Maintain outer border style when in error state
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color:Colors.red.shade400,
          // Keep the same border color as enabled state
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      hintText: hintText,
      hintStyle:TextStyle(color: Colors.grey.shade100),
      suffixIcon: isWidgetRequired ? widget : null,
      //   onPressed: () {
      //     setState(() {
      //       obscurePassword = !obscurePassword; // Toggle password visibility
      //     });
      //   },
      //   icon: Icon(
      //     obscurePassword ? Icons.visibility : Icons.visibility_off,
      //     color: Colors.grey, // Choose your preferred icon color
      //   ),
      // )
    );
  }