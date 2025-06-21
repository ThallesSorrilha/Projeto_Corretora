import 'package:flutter/material.dart';
import 'package:projeto_corretora/componentes/app_bar_salvar.dart';
import 'package:projeto_corretora/utils/personalizacao_formulario.dart';

class FormEstado extends StatefulWidget {
  const FormEstado({super.key});

  @override
  State<FormEstado> createState() => _FormEstadoState();
}

class _FormEstadoState extends State<FormEstado> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _siglaController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _siglaController.dispose();
    super.dispose();
  }

  void _salvar() {
    final formValido = _formKey.currentState?.validate() ?? false;
    if (formValido) {
      final estadoData = {
        'nome': _nomeController.text.trim(),
        'sigla': _siglaController.text.trim(),
      };

      //...
      print('Estado salvo: $estadoData');

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Estado salvo com sucesso!')));

      //Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSalvar(titulo: "Cadastrar Estado", aoSalvar: _salvar),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField(
                _nomeController,
                'Nome',
                validators: [FieldValidatorType.required],
              ),
              buildTextField(
                _siglaController,
                'Sigla',
                validators: [FieldValidatorType.required],
              ),
              ElevatedButton(onPressed: _salvar, child: Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}
