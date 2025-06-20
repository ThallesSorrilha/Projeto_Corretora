import 'package:flutter/material.dart';
import 'package:projeto_corretora/utils/personalizacao_formulario.dart';

class FormCidade extends StatefulWidget {
  const FormCidade({super.key});

  @override
  State<FormCidade> createState() => _FormCidadeState();
}

class _FormCidadeState extends State<FormCidade> {
  final _formKey = GlobalKey<FormState>();

  // Controllers para os campos de texto
  final TextEditingController _nomeController = TextEditingController();

  // Campos de seleção
  String? _estado;

  // Dados pré-definidos para as opções
  final List<String> estados = ['SP', 'RJ', 'MG'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Estado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField(_nomeController, 'Nome', validators: [FieldValidatorType.required],),
              buildDropdownField('Estado', estados, (value) {
                setState(() {
                  _estado = value;
                });
              }, _estado, validators: [FieldValidatorType.required],),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Processar o cadastro
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Cadastro realizado com sucesso!')));
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
