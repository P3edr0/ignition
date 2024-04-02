import 'package:flutter/material.dart';
import 'package:ignition/utils/constants.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget(
      {super.key,
      required this.title,
      required this.controller,
      this.isPassword = false,
      this.action = TextInputAction.next});

  final String title;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputAction action;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        title,
        style: const TextStyle(
            color: ProjectColors.orange,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
      Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: ProjectColors.orange.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Form(
            child: TextField(
          obscureText: isPassword,
          controller: controller,
          textInputAction: action,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
        )),
      )
    ]);
  }
}
