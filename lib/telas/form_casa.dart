import 'package:flutter/material.dart';
import 'package:projeto_corretora/componentes/app_bar_salvar.dart';
import 'package:projeto_corretora/componentes/busca_multipla.dart';
import 'package:projeto_corretora/componentes/entrada_numerica.dart';
import 'package:projeto_corretora/componentes/entrada_opcao.dart';
import 'package:projeto_corretora/componentes/entrada_select.dart';
import 'package:projeto_corretora/componentes/entrada_texto.dart';
import 'package:projeto_corretora/telas/form_pessoa.dart';
import 'package:projeto_corretora/utils/mascaras.dart';
import 'package:flutter/services.dart';
import 'package:projeto_corretora/dto/dto.dart';
import 'package:projeto_corretora/utils/validacao.dart';

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

  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  final List<Cidade> _cidadeOpcoes = selectCidades;
  final List<Usuario> _usuariosOpcoes = selectUsuarios;
  final List<String> tiposLista = ['Casa', 'Apartamento'];

  Cidade? _cidadeSelecionada;
  String? _tipoSelecionado;
  List<Usuario> _usuariosSelecionados = [];

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
      final casaData = {
        'cidade': _cidadeSelecionada,
        'bairro': _bairroController.text.trim(),
        'logradouro': _logradouroController.text.trim(),
        'numero': _numeroController.text.trim(),
        'tipo': _tipoSelecionado,
        'area': _areaController.text.trim(),
        'preco': _precoController.text.trim(),
        'descricao': _descricaoController.text.trim(),
        'usuarios': _usuariosSelecionados,
      };

      //...
      print('Casa salva: $casaData');

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Casa salva com sucesso!')));

      //Navigator.of(context).pop();
    }
  }

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
              EntradaSelect<Cidade>(
                opcoes: _cidadeOpcoes,
                valorSelecionado: _cidadeSelecionada,
                rotulo: 'Cidade',
                validator: ValidadorBuilder().obrigatorioObjeto,
                textoPadrao: 'Selecione uma cidade',
                onChanged: (cidade) {
                  setState(() {
                    _cidadeSelecionada = cidade;
                  });
                },
              ),
              EntradaTexto(
                controller: _bairroController,
                label: 'Bairro',
                validator: ValidadorBuilder().obrigatorio().build(),
              ),
              EntradaTexto(
                controller: _logradouroController,
                label: 'Logradouro',
                validator: ValidadorBuilder().obrigatorio().build(),
              ),
              EntradaTexto(
                controller: _numeroController,
                label: 'Nº',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: ValidadorBuilder().obrigatorio().build(),
              ),
              EntradaOpcao(
                rotulo: 'Tipo',
                opcoes: tiposLista,
                onChanged: (value) {
                  setState(() {
                    _tipoSelecionado = value;
                  });
                },
                valorSelecionado: _tipoSelecionado,
                validator: ValidadorBuilder().obrigatorioObjeto,
              ),
              EntradaNumerica(
                controller: _areaController,
                label: 'Área',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: ValidadorBuilder().obrigatorio().build(),
              ),
              EntradaNumerica(
                controller: _precoController,
                label: 'Preço',
                keyboardType: TextInputType.number,
                inputFormatters: [MaskUtils.realMask],
                validator: ValidadorBuilder().obrigatorio().build(),
              ),
              EntradaTexto(
                controller: _descricaoController,
                label: 'Descrição',
              ),
              CampoBuscaMultipla<Usuario>(
                opcoes: _usuariosOpcoes,
                rotulo: 'Usuários',
                textoPadrao: 'Selecione um ou mais usuários',
                onChanged: (usuarios) {
                  setState(() {
                    _usuariosSelecionados = usuarios;
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
