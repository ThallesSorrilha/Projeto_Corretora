import 'package:flutter/material.dart';

class FormularioCasa extends StatefulWidget {
  @override
  _FormularioCasaState createState() => _FormularioCasaState();
}

class _FormularioCasaState extends State<FormularioCasa> {
  final _formKey = GlobalKey<FormState>();

  /*
  Cidade
  Bairro
  Logradouro
  Número
  Tipo
  Área
  Preço
  */

  // Controllers para os campos de texto
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();

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
      appBar: AppBar(title: Text('Cadastro de Casa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildDropdownField('Cidade', cidades, (value) {
                setState(() {
                  _cidade = value;
                });
              }, _cidade),
              _buildTextField(_bairroController, 'Bairro'),
              _buildTextField(_logradouroController, 'Logradouro'),
              _buildTextField(_numeroController, 'Nº'),
              _buildTextField(_tipoController, 'Tipo'),
              _buildTextField(_areaController, 'Área'),
              _buildTextField(_precoController, 'Preço'),
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

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label é obrigatório';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    List<String> options,
    ValueChanged<String?> onChanged,
    String? selectionField,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        value: selectionField,
        onChanged: onChanged,
        items:
            options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
        validator: (value) {
          if (value == null) {
            return '$label é obrigatório';
          }
          return null;
        },
      ),
    );
  }
}
