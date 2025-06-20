import 'package:flutter/material.dart';
import 'package:projeto_corretora/utils/personalizacao_formulario.dart';
import 'package:flutter/services.dart';

class FormCasa extends StatefulWidget {
  const FormCasa({super.key});

  @override
  State<FormCasa> createState() => _FormCasaState();
}

class _FormCasaState extends State<FormCasa> {
  final _formKey = GlobalKey<FormState>();

  // Controllers para os campos de texto
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  // Campos de seleção
  String? _cidade;
  String? _tipo;

  // Dados pré-definidos para as opções
  final List<String> cidades = [
    'São Paulo',
    'Rio de Janeiro',
    'Belo Horizonte',
  ];

  final List<String> tipos = ['Casa', 'Apartamento'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Casa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildDropdownField(
                'Cidade',
                cidades,
                (value) {
                  setState(() {
                    _cidade = value;
                  });
                },
                _cidade,
                validators: [FieldValidatorType.required],
              ),
              buildTextField(
                _bairroController,
                'Bairro',
                validators: [FieldValidatorType.required],
              ),
              buildTextField(
                _logradouroController,
                'Logradouro',
                validators: [FieldValidatorType.required],
              ),
              buildTextField(
                _numeroController,
                'Nº',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validators: [FieldValidatorType.required],
              ),
              buildDropdownField(
                'Tipo',
                tipos,
                (value) {
                  setState(() {
                    _tipo = value;
                  });
                },
                _tipo,
                validators: [FieldValidatorType.required],
              ),
              buildTextField(
                _areaController,
                'Área',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validators: [FieldValidatorType.required],
              ),
              buildTextField(
                _precoController,
                'Preço',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validators: [FieldValidatorType.required],
              ),
              buildTextField(_descricaoController, 'Descrição'),
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
