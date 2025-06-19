import 'package:flutter/material.dart';
import 'package:projeto_corretora/utils/personalizacao_formulario.dart';

class FormularioEstado extends StatefulWidget {
  @override
  _FormularioEstadoState createState() => _FormularioEstadoState();
}

class _FormularioEstadoState extends State<FormularioEstado> {
  final _formKey = GlobalKey<FormState>();

  // Controllers para os campos de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _siglaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Estado')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField(_nomeController, 'Nome', validators: [FieldValidatorType.required],),
              buildTextField(_siglaController, 'Sigla', validators: [FieldValidatorType.required],),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Processar o cadastro
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Cadastro realizado com sucesso!'),
                      ),
                    );
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
