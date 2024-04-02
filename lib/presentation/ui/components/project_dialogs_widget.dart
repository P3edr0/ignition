import 'package:flutter/material.dart';
import 'package:ignition/utils/constants.dart';

class ProjectDialogsWidget {
  Future alertDialog(BuildContext context, String title, String text,
      String buttonLabel, Function() callback) async {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: 220,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(children: [
            const Icon(
              Icons.info_outlined,
              size: 50,
              color: Colors.black,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                  color: ProjectColors.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
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
                  onPressed: callback,
                  child: Text(
                    buttonLabel,
                    style: const TextStyle(
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
    );
  }
}
