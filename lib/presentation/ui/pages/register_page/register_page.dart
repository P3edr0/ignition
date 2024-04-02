import 'package:flutter/material.dart';
import 'package:ignition/presentation/ui/components/project_dialogs_widget.dart';
import 'package:ignition/presentation/ui/components/textform_widget.dart';
import 'package:ignition/presentation/ui/controller/register_controller.dart';
import 'package:ignition/presentation/ui/pages/login_page/login_page.dart';
import 'package:ignition/utils/constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _colorController;
  late Animation<Color?> _colorAnimation;
  final RegisterController _registerController = RegisterController();
  bool loading = false;
  @override
  void initState() {
    super.initState();

    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _colorAnimation = ColorTween(
      begin: Colors.orange[600],
      end: ProjectColors.orange,
    ).animate(_colorController);

    _colorController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.orange,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                color: ProjectColors.orange,
                gradient: LinearGradient(colors: [
                  Colors.red,
                  ProjectColors.orange,
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(ProjectImages.logoIgd, height: 150),
                const Text(
                  "Registrar Novo Igde",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(280),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(140))),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 100),
                      height: 570,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[700]!,
                                offset: const Offset(2, 2),
                                blurRadius: 03),
                            BoxShadow(
                                color: Colors.grey[700]!,
                                offset: const Offset(-2, -2),
                                blurRadius: 03)
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: Column(children: [
                        const SizedBox(height: 40),
                        TextFormWidget(
                            title: 'Nome',
                            controller: _registerController.nameController),
                        TextFormWidget(
                            title: 'Email',
                            controller: _registerController.emailController),
                        TextFormWidget(
                          title: 'Senha',
                          controller: _registerController.passwordController,
                          isPassword: true,
                        ),
                        TextFormWidget(
                          title: 'Confirmar Senha',
                          controller:
                              _registerController.confirmPasswordController,
                          isPassword: true,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        AnimatedBuilder(
                            animation: _colorAnimation,
                            builder: (context, child) {
                              return ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          _colorAnimation.value),
                                      maximumSize:
                                          const MaterialStatePropertyAll(
                                              Size(200, 50))),
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    var result = await _registerController
                                        .insertIgde(
                                          _registerController
                                              .nameController.text,
                                          _registerController
                                              .emailController.text,
                                          _registerController
                                              .passwordController.text,
                                          _registerController
                                              .confirmPasswordController.text,
                                        )
                                        .whenComplete(() => Future.delayed(
                                            const Duration(seconds: 2)))
                                        .whenComplete(() {
                                      setState(() {
                                        loading = false;
                                      });
                                    });
                                    if (result["result"] == 'fail') {
                                      if (!context.mounted) return;
                                      await ProjectDialogsWidget().alertDialog(
                                          context,
                                          "Erro",
                                          result["message"],
                                          'Tentar',
                                          () => Navigator.pop(context));
                                    } else {
                                      if (!context.mounted) return;
                                      await ProjectDialogsWidget().alertDialog(
                                          context,
                                          "Sucesso",
                                          result["message"],
                                          'Logar',
                                          () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const LoginPage())));
                                    }
                                  },
                                  child: loading
                                      ? const SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Registrar",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.arrow_circle_right_rounded,
                                              color: Colors.white,
                                              size: 22,
                                            ),
                                          ],
                                        ));
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        TextButton(
                          onPressed: () async {
                            if (!context.mounted) return;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginPage()));
                          },
                          child: const Text(
                            'Voltar para Login',
                            style: TextStyle(
                                color: ProjectColors.orange,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
