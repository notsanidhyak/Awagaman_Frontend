import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  TextEditingController? textEditingController;
  IconData? iconData;
  String? hintText;
  // String? labelText;S
  bool? isObscure = true;
  bool? enabled = true;
  TextInputType? inputType;

  CustomTextField({
    super.key,
    // Key? key,
    this.textEditingController,
    this.iconData,
    this.hintText,
    // this.labelText,
    this.isObscure,
    this.enabled,
    this.inputType,
  });
  // : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Container(
        height: 48,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 30, 45, 65),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        child: TextFormField(
          enabled: widget.enabled,
          obscureText: widget.isObscure!,
          controller: widget.textEditingController,
          cursorColor: Colors.white,
          keyboardType: widget.inputType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 30, 45, 65))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 30, 45, 65))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 30, 45, 65))),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 30, 45, 65))),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 6,
            ),
            fillColor: const Color.fromARGB(255, 30, 45, 65),
            filled: false,
            prefixIcon: Icon(
              widget.iconData,
              color: Colors.grey,
            ),
            focusColor: Colors.white,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
            // labelText: widget.labelText,
            // labelStyle: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
