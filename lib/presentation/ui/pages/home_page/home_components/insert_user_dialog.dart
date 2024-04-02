import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ignition/presentation/ui/components/project_dialogs_widget.dart';
import 'package:ignition/presentation/ui/components/textform_widget.dart';
import 'package:ignition/presentation/ui/controller/home_controller.dart';
import 'package:ignition/utils/constants.dart';

Future insertUserDialog(BuildContext context, String token) async {
  HomeController homeController = HomeController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController tagsController = TextEditingController();

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
              Icons.person,
              size: 50,
              color: Colors.black,
            ),
            const SizedBox(height: 5),
            const Text(
              'Dados do cliente',
              style: TextStyle(
                  color: ProjectColors.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            TextFormWidget(title: 'Nome', controller: nameController),
            TextFormWidget(title: 'Email', controller: emailController),
            TextFormWidget(title: 'Tags', controller: tagsController),
            const Text(
              'Insira as tags separadas por vírgula',
              style: TextStyle(
                  color: ProjectColors.orange,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
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
                    Map result = await homeController.insertUser(
                        nameController.text,
                        emailController.text,
                        tagsController.text,
                        token);
                    if (result['result'] == 'sucess') {
                      if (!context.mounted) {
                        log("Context não habilitado");
                        return;
                      }
                      Navigator.pop(context);

                      Future.delayed(const Duration(milliseconds: 60))
                          .whenComplete(() async => await ProjectDialogsWidget()
                              .alertDialog(
                                  context,
                                  'Sucesso',
                                  '${result['message']}',
                                  'Sair',
                                  () async => Navigator.pop(context)));
                    } else {
                      if (!context.mounted) {
                        log("Context não habilitado");
                        return;
                      }
                      Navigator.pop(context);

                      Future.delayed(const Duration(milliseconds: 600))
                          .whenComplete(() async => await ProjectDialogsWidget()
                              .alertDialog(
                                  context,
                                  'Erro',
                                  '${result['message']}',
                                  'Sair',
                                  () async => Navigator.pop(context)));
                    }
                  },
                  child: const Text(
                    'Inserir',
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
