import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/validators.dart';
import '../models/user.dart';
import '../providers/user_manager.dart';

class AuthDialog extends StatefulWidget {
  @override
  _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool _createUser = false;
  bool _error = false;
  String textError = "";

  final User _user = User();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SizedBox(
            width: 600,
            child: Container(
              margin: const EdgeInsets.all(8),
              child: Form(
                key: formKey,
                child: Consumer<UserManager>(
                  builder: (_, userManager, child) {
                    return ListView(
                      padding: const EdgeInsets.all(8),
                      shrinkWrap: true,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.transparent,
                          child: Image.asset("assets/images/logo.png"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Bem-vindo",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        if (_createUser)
                          TextFormField(
                            enabled: !userManager.loading,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                hintText: 'Nome Completo',
                                hintStyle:
                                    Theme.of(context).textTheme.bodyText1),
                            style: Theme.of(context).textTheme.bodyText1,
                            validator: (name) {
                              if (name!.isEmpty) {
                                return 'Campo obrigatório';
                              } else if (name.trim().split(' ').length <= 1) {
                                return 'Preencha seu Nome completo';
                              }
                              return null;
                            },
                            onSaved: (name) => _user.name = name,
                          ),
                        if (_createUser)
                          const SizedBox(
                            height: 16,
                          ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailController,
                          enabled: !userManager.loading,
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: Theme.of(context).textTheme.bodyText1),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          validator: (email) {
                            if (!emailValid(email!)) {
                              return 'E-mail inválido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: passController,
                          enabled: !userManager.loading,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            hintText: 'Senha',
                            hintStyle: Theme.of(context).textTheme.bodyText1,
                          ),
                          autocorrect: false,
                          obscureText: true,
                          style: Theme.of(context).textTheme.bodyText1,
                          validator: (pass) {
                            if (pass!.isEmpty || pass.length < 6) {
                              return 'Senha inválida';
                            }
                            return null;
                          },
                        ),
                        if (!_createUser)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Esqueci minha senha',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (_createUser)
                          TextFormField(
                            enabled: !userManager.loading,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                hintText: 'Repita a Senha',
                                hintStyle:
                                    Theme.of(context).textTheme.bodyText1),
                            obscureText: true,
                            validator: (pass) {
                              if (pass!.isEmpty) {
                                return 'Campo obrigatório';
                              } else if (passController.text != pass) {
                                return 'Senhas devem ser iguais';
                              }
                              return null;
                            },
                            onSaved: (pass) => _user.confirmPassword = pass,
                          ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (_error)
                          Text(
                            textError,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.red),
                          ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: constraints.biggest.width * 2 / 3,
                          height: 44,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _createUser
                                          ? _createUser = false
                                          : _createUser = true;
                                      _error = false;
                                    });
                                  },
                                  child: FittedBox(
                                    child: Text(
                                      _createUser ? 'Entrar' : 'CRIAR CONTA',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      _user.email = emailController.text;
                                      _user.password = passController.text;

                                      if (formKey.currentState!.validate()) {
                                        Provider.of<UserManager>(context,
                                                listen: false)
                                            .signIn(_user, onFail: (e) {
                                          debugPrint('Falha ao entrar: $e');
                                          setState(() {
                                            _error = true;
                                            textError = 'Falha ao entrar: $e';
                                          });
                                        }, onSuccess: () {
                                          Navigator.of(context).pop();
                                        });
                                      }
                                    },
                                    child: FittedBox(
                                      child: Text(
                                        _createUser ? 'Criar' : 'Entrar',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(color: Colors.white),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
