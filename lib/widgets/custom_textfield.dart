import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final String hintText;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.text,
    required this.hintText,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          maxLines: 1,
          cursorColor: Colors.blueGrey,
          keyboardType: keyboardType,
          onTapOutside: (focusNode) {
            FocusScope.of(context).unfocus();
          },
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
            filled: true,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: Colors.blueGrey,
                width: 2,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: Colors.blueGrey,
                width: 2,
              ),
            ),
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
