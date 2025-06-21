import 'package:flutter/material.dart';
import 'package:projeto_corretora/componentes/app_bar_salvar.dart';
import 'package:projeto_corretora/componentes/campo_opcoes.dart';
import 'package:projeto_corretora/utils/personalizacao_formulario.dart';
import 'package:flutter/services.dart';
import 'package:projeto_corretora/dto/dto.dart';

class Cidade extends DTO {
  Cidade({required super.id, required super.nome});
}

List<Cidade> selectCidades = [
  Cidade(id: 1, nome: 'Navegantes'),
  Cidade(id: 2, nome: 'Florianópolis'),
  Cidade(id: 3, nome: 'Curitiba'),
  Cidade(id: 4, nome: 'Maringá'),
  Cidade(id: 5, nome: 'Ouro Preto'),
  Cidade(id: 6, nome: 'Belo Horizonte'),
];

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
  final List<Cidade> _cidadeOpcoes = selectCidades;

  Cidade? _cidadeSelecionada;
  String? _tipo;

  @override
  void dispose() {
    _bairroController.dispose();
    _logradouroController.dispose();
    _numeroController.dispose();
    _areaController.dispose();
    _precoController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _salvar() {
    final formValido = _formKey.currentState?.validate() ?? false;
    if (formValido) {
      // Formulário válido, pode prosseguir com cadastro ou salvar os dados
      final casaData = {
        'cidade': _cidadeSelecionada,
        'bairro': _bairroController.text.trim(),
        'logradouro': _logradouroController.text.trim(),
        'numero': _numeroController.text.trim(),
        'tipo': _tipo,
        'area': _areaController.text.trim(),
        'preco': _precoController.text.trim(),
        'descricao': _descricaoController.text.trim(),
      };

      //...
      print('Aluno salvo: $casaData');

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Casa salva com sucesso!')));

      // Opcional: limpar o formulário ou voltar
      Navigator.of(context).pop();
    }
  }

  final List<String> tipos = ['Casa', 'Apartamento'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSalvar(titulo: "Cadastrar Casa", aoSalvar: _salvar),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CampoOpcoes<Cidade>(
                opcoes: _cidadeOpcoes,
                valorSelecionado: _cidadeSelecionada,
                rotulo: 'Cidade',
                textoPadrao: 'Selecione uma cidade',
                onChanged: (cidade) {
                  setState(() {
                    _cidadeSelecionada = cidade;
                  });
                },
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
              ElevatedButton(onPressed: _salvar, child: Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}
