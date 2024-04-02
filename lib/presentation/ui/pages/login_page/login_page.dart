import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ignition/presentation/ui/components/project_dialogs_widget.dart';
import 'package:ignition/presentation/ui/components/textform_widget.dart';
import 'package:ignition/presentation/ui/controller/login_controller.dart';
import 'package:ignition/presentation/ui/pages/home_page/home_page.dart';
import 'package:ignition/presentation/ui/pages/register_page/register_page.dart';
import 'package:ignition/utils/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final LoginController _loginController = LoginController();
  late AnimationController _colorController;
  late Animation<Color?> _colorAnimation;
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
                gradient:
                    LinearGradient(colors: [ProjectColors.orange, Colors.red])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(ProjectImages.logoIgd, height: 150),
                const Text(
                  "Seja Bem Vindo IGDÊ!",
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(280),
                                  bottomRight: Radius.circular(140))),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 100),
                      height: 400,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                offset: const Offset(2, 2),
                                blurRadius: 03),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                offset: const Offset(-2, -2),
                                blurRadius: 03)
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: Column(children: [
                        const SizedBox(height: 40),
                        TextFormWidget(
                            title: "Email",
                            controller: _loginController.emailController),
                        TextFormWidget(
                          title: "Senha",
                          controller: _loginController.passwordController,
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
                                    log(_loginController.emailController.text);
                                    log(_loginController
                                        .passwordController.text);
                                    String result =
                                        await _loginController.login(
                                            _loginController
                                                .emailController.text,
                                            _loginController
                                                .passwordController.text);
                                    setState(() {
                                      Future.delayed(const Duration(seconds: 2))
                                          .whenComplete(() => loading = false);
                                    });

                                    if (result == '') {
                                      if (!context.mounted) return;
                                      await ProjectDialogsWidget().alertDialog(
                                          context,
                                          "Erro",
                                          "Falha ao fazer o login",
                                          'Tentar',
                                          () => Navigator.pop(context));
                                    } else {
                                      if (!context.mounted) return;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  HomePage(token: result)));
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
                                              "Entrar",
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
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return const RegisterPage();
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.fastLinearToSlowEaseIn;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));

                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'Registrar-se',
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
