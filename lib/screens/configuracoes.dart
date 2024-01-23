import 'package:flutter/material.dart';
import '../stores/user_store.dart';

class ConfiguracoesDialog extends StatefulWidget {
  final UserStore userStore;

  const ConfiguracoesDialog({
    Key? key,
    required this.userStore,
  }) : super(key: key);

  @override
  ConfiguracoesDialogState createState() => ConfiguracoesDialogState();
}

class ConfiguracoesDialogState extends State<ConfiguracoesDialog> {
  late TextEditingController nomeController;
  late TextEditingController telefoneController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.userStore.username);
    telefoneController = TextEditingController(text: widget.userStore.phone);
    emailController = TextEditingController(text: widget.userStore.email);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Dialog(
              child: Form(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Configurações',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('Nome do usuário'),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: nomeController,
                          decoration: InputDecoration(
                            hintText: 'Nome',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('Telefone'),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: telefoneController,
                          decoration: InputDecoration(
                            hintText: 'Telefone',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('Email'),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            child: const Text('Cancelar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Salvar'),
                            onPressed: () {
                              widget.userStore.saveUser(nomeController.text);
                              widget.userStore.savePhone(telefoneController.text);
                              widget.userStore.saveEmail(emailController.text);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}