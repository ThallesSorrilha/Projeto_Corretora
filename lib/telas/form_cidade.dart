import 'package:flutter/material.dart';
import 'package:projeto_corretora/componentes/campo_opcoes.dart';
import 'package:projeto_corretora/dto/dto.dart';
import 'package:projeto_corretora/utils/personalizacao_formulario.dart';
import 'package:projeto_corretora/componentes/app_bar_salvar.dart';

class Estado extends DTO {
  Estado({required super.id, required super.nome});
}

List<Estado> selectEstados = [
  Estado(id: 1, nome: 'Santa Catarina'),
  Estado(id: 2, nome: 'Paraná'),
  Estado(id: 3, nome: 'Minas Gerais'),
];

class FormCidade extends StatefulWidget {
  const FormCidade({super.key});

  @override
  State<FormCidade> createState() => _FormCidadeState();
}

class _FormCidadeState extends State<FormCidade> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final List<Estado> _estadoOpcoes = selectEstados;

  Estado? _estadoSelecionado;

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _salvar() {
    final formValido = _formKey.currentState?.validate() ?? false;
    if (formValido) {
      final cidadeData = {
        'nome': _nomeController.text.trim(),
        'estado': _estadoSelecionado,
      };

      //...
      print('Cidade salva: $cidadeData');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cidade salva com sucesso!')),
      );

      //Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSalvar(titulo: "Cadastrar Cidade", aoSalvar: _salvar),
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
              CampoOpcoes<Estado>(
                opcoes: _estadoOpcoes,
                valorSelecionado: _estadoSelecionado,
                rotulo: 'Estado',
                eObrigatorio: true,
                textoPadrao: 'Selecione um Estado',
                onChanged: (estado) {
                  setState(() {
                    _estadoSelecionado = estado;
                  });
                },
              ),
              ElevatedButton(onPressed: _salvar, child: Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}
