  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:fluttertoast/fluttertoast.dart';

  navigateTo(context, widget) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

  navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => widget), (route) => false);
  Widget defaultFormField({
    Color cursorColor,
    @required TextInputType type,
    @required TextEditingController controller,
    String labelText,
    Color labelColor,
    double borderRaduis,
    Color borderColor,
    IconData prefix,
    IconData suffix,
    bool isPassword =false,
    Color iconColor,
    Color focusColor,
    Color fillcolor,
    double focusedBorderRaduis,
    Color focusdborderColor,
    double curoserHeight,
    double enabledBorderRaduis,
    double paddingContent,
    Color enabledBorderColor,
    double errorBorderRaduis,
    Color errorBorderColor,
    @required   Function  validate ,
    Function  onChange ,
    Function  onSubmit ,
    Function   onTap,
    Function   suffixPressed,
  }) => TextFormField(
        onChanged: onChange,
        onFieldSubmitted: onSubmit,
        onTap: onTap ,
        obscureText: isPassword,
        validator: validate ,
        cursorHeight: curoserHeight,
        cursorColor: cursorColor,
        keyboardType: type,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: EdgeInsets.symmetric(vertical: paddingContent),
          labelStyle: TextStyle(color: labelColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRaduis),
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
          prefixIcon: Icon(
            prefix,
            color: iconColor,
          ),
          suffixIcon: suffix != null
              ? IconButton(
            onPressed: suffixPressed,
            icon: Icon(
              suffix,
            ),
          )
              : null,
          focusColor: focusColor,
          fillColor: fillcolor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(focusedBorderRaduis),
            borderSide: BorderSide(
              color: focusdborderColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(enabledBorderRaduis),
            borderSide: BorderSide(
              color: enabledBorderColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(errorBorderRaduis),
            borderSide: BorderSide(
              color: errorBorderColor,
            ),
          ),
        ),
      );
  Widget defaultButton({@required Function function , @required text})=> Container(
    width: 200,
    decoration: BoxDecoration(
      color: Colors.deepOrange,
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(50),
        topRight: Radius.circular(50),
        topLeft: Radius.circular(50),
        bottomLeft: Radius.circular(50),
      ),
    ),
    child: MaterialButton(
      onPressed: function,
      child: Text(text),
      height: 50,
      textColor: Colors.white,
    ),
  );
  void showToast ({@required String text,@required ToastStates state })=>  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    fontSize: 16.0,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    timeInSecForIosWeb: 5,
  );
  enum ToastStates {SUCCESS , ERROR , WARNING}
  Color chooseToastColor(ToastStates state){
    Color color;
    switch (state){
      case  ToastStates.SUCCESS :
        color= Colors.green;
        break;
      case  ToastStates.ERROR :
        color=Colors.red;
        break;
      case  ToastStates.WARNING :
        color=Colors.amber;
        break;
    }
    return color;
  }
  Widget myDivider() => Padding(
    padding: const EdgeInsetsDirectional.only(
      start: 20.0,
    ),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    ),
  );