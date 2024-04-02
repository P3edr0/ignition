import 'package:flutter/material.dart';
import 'package:ignition/presentation/ui/components/textform_widget.dart';
import 'package:ignition/presentation/ui/controller/home_controller.dart';
import 'package:ignition/utils/constants.dart';

Future updateIgdeDialog(
  BuildContext context,
  String name,
  String email,
  int id,
  String token,
) async {
  TextEditingController nameController = TextEditingController(text: name);
  TextEditingController emailController = TextEditingController(text: email);
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  HomeController homeController = HomeController();
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Dialog(
      child: Container(
        height: 420,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: SingleChildScrollView(
          child: Column(children: [
            const Icon(
              Icons.factory,
              size: 50,
              color: Colors.black,
            ),
            const SizedBox(height: 5),
            const Text(
              'Atualizar Igde',
              style: TextStyle(
                  color: ProjectColors.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            TextFormWidget(title: 'Nome', controller: nameController),
            TextFormWidget(title: 'Email', controller: emailController),
            TextFormWidget(title: 'Nova Senha', controller: passwordController),
            TextFormWidget(
                title: 'Confirmar Nova Senha',
                controller: newPasswordController),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      maximumSize:
                          const MaterialStatePropertyAll(Size(220, 50)),
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.lightBlue[800],
                      )),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Voltar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                      maximumSize: MaterialStatePropertyAll(Size(220, 50)),
                      backgroundColor: MaterialStatePropertyAll(
                        ProjectColors.orange,
                      )),
                  onPressed: () async {
                    await homeController.updateIgde(
                        id,
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                        newPasswordController.text,
                        token,
                        context);
                  },
                  child: const Text(
                    'Atualizar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    ),
  );
}
