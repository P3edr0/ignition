import 'package:flutter/material.dart';

Widget loadComponent() {
  return const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 8,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Carregando Listas...',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
