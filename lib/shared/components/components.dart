import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String? token;

class DefaultFormField extends StatelessWidget {
  const DefaultFormField(
      {Key? key,
      required this.controller,
      required this.type,
      required this.validate,
       this.label,
      required this.border,
      required this.prefix,
      this.suffix,
      required this.obscure,
      this.onPressed}
      )
      : super(key: key);
  final TextEditingController controller;
  final TextInputType type;
  final String? Function(String? value)? validate;
  final String? label;
  final InputBorder border;
  final IconData prefix;
  final IconData? suffix;
  final bool obscure;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validate,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: border,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(onPressed: onPressed, icon: Icon(suffix)),
      ),
    );
  }
}

 Widget defaultTextButton({
  final double width = double.infinity,
  final Color color = Colors.teal,
  required final void Function()? onPressed,
  required final String text,
  final FontWeight weight = FontWeight.bold,
  final double fontSize = 22,
  final Color colorText = Colors.white,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
         color: color,
          borderRadius: BorderRadius.circular(30),
      ),
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style:  TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              color: Colors.white,
            ),
          )),
    );

 void navigateTo(context , widget)=>Navigator.push(context,
    MaterialPageRoute(
        builder: (context)=>widget
    ),
);

 void navigateAndFinish(context , widget)=> Navigator.pushAndRemoveUntil(context,
  MaterialPageRoute(
    builder:(context)=>widget
  ),
      (Route<dynamic>route)=>false,
);

 void showToast({required String msg,required ToastStates states})=>
     Fluttertoast.showToast(
     msg: msg,
     toastLength: Toast.LENGTH_LONG,
     gravity: ToastGravity.BOTTOM,
     timeInSecForIosWeb: 5,
     backgroundColor: chooseToastColor(states),
     textColor: Colors.white,
     fontSize: 16.0);

 enum ToastStates{SUCCESS,ERROR,WARNING}
Color chooseToastColor(ToastStates states) { Color color;
   switch(states){
     case ToastStates.SUCCESS:
     color = Colors.green;
       break;
     case ToastStates.WARNING:
       color = Colors.amber;
       break;
     case ToastStates.ERROR:
       color = Colors.red;
       break;
   }
   return color;
}


