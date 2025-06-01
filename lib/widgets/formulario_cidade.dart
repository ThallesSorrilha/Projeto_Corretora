import 'package:flutter/material.dart';

class FormularioCidade extends StatefulWidget {
  @override
  _FormularioCidadeState createState() => _FormularioCidadeState();
}

class _FormularioCidadeState extends State<FormularioCidade> {
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
              _buildTextField(_nomeController, 'Nome'),
              _buildDropdownField('Estado', estados, (value) {
                setState(() {
                  _estado = value;
                });
              }, _estado),
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
    String? selectionField
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
