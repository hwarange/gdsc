import 'package:flutter/material.dart';
import 'package:gdsc/commmon/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String ? labelText;
  final String ? hintText;
  final String ? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String> ? onChanged;
  final TextInputType ? keyboardType;
  final TextEditingController ? controller;


  const CustomTextFormField({
    this.labelText,
    this.onChanged,
    this.obscureText = false,
    this.autofocus = false,
    this.hintText,
    this.errorText,
    this.keyboardType,
    this.controller,
    Key ? key
  }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.cyan,
        width: 1.0,
      )
    );

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: BG_COLOR,
      // 비밀번호 입력할때(안보이기 기능)
      obscureText: obscureText,
      // 자동커서
      autofocus: autofocus,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
          labelText: labelText,
          hintText: hintText ,
          errorText: errorText,
          hintStyle: TextStyle(
            color: LOGIN_COLOR,
            fontSize: 14.0,
          ),
        fillColor: W_BOX_COLOR,
        //false 배경색없음
        filled: true,
        // 모든 input 상태의 기본 스타일 세팅
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: BODY_TEXT_COLOR,
          )
        )
        //실제로 글 쓰면 사라짐
      ),
    );
  }
}


