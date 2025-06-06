import 'package:flutter/material.dart';
import 'package:projeto_corretora/utils/personalizacao_formulario.dart';

class FormularioPessoa extends StatefulWidget {
  @override
  _FormularioPessoaState createState() => _FormularioPessoaState();
}

class _FormularioPessoaState extends State<FormularioPessoa> {
  final _formKey = GlobalKey<FormState>();

  // Controllers para os campos de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Campos de seleção
  String? _cidade;

  // Dados pré-definidos para as opções
  final List<String> cidades = [
    'São Paulo',
    'Rio de Janeiro',
    'Belo Horizonte',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Usuário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField(_nomeController, 'Nome'),
              buildTextField(_sobrenomeController, 'Sobrenome'),
              buildTextField(
                _telefoneController,
                'Telefone',
                keyboardType: TextInputType.number,
                inputFormatters: [telefoneMask],
              ),
              buildTextField(
                _emailController,
                'E-mail',
                validator: verifyEmail,
              ),
              buildDropdownField('Cidade', cidades, (value) {
                setState(() {
                  _cidade = value;
                });
              }, _cidade),
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
