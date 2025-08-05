import 'package:flutter/material.dart';
import 'package:projeto_corretora/componentes/app_bar_salvar.dart';
import 'package:projeto_corretora/componentes/busca_multipla.dart';
import 'package:projeto_corretora/componentes/entrada_numerica.dart';
import 'package:projeto_corretora/componentes/entrada_opcao.dart';
import 'package:projeto_corretora/componentes/entrada_select.dart';
import 'package:projeto_corretora/componentes/entrada_texto.dart';
import 'package:projeto_corretora/dao/dao_casa.dart';
import 'package:projeto_corretora/dao/dao_cidade.dart';
import 'package:projeto_corretora/dao/dao_pessoa.dart';
import 'package:projeto_corretora/dto/dto_casa.dart';
import 'package:projeto_corretora/dto/dto_cidade.dart';
import 'package:projeto_corretora/dto/dto_pessoa.dart';
import 'package:projeto_corretora/utils/mascaras.dart';
import 'package:flutter/services.dart';
import 'package:projeto_corretora/utils/validacao.dart';
import 'package:projeto_corretora/utils/definicoes_gerais.dart';
import 'package:projeto_corretora/componentes/botao_interruptor.dart';

class FormCasa extends StatefulWidget {
  const FormCasa({super.key});

  @override
  State<FormCasa> createState() => _FormCasaState();
}

class _FormCasaState extends State<FormCasa> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  String? _tipoSelecionado;
  bool _ativo = true;

  List<CidadeDTO> _cidadesOpcoes = [];
  CidadeDTO? _cidadesSelecionadas;

  List<PessoaDTO> _pessoasOpcoes = [];
  List<PessoaDTO>? _pessoasSelecionadas;

  @override
  void initState() {
    super.initState();
    _carregarCidades();
    _carregarPessoas();
  }

  Future<void> _carregarCidades() async {
    final cidades = await CidadeDAO().consultarTodos();
    setState(() {
      _cidadesOpcoes = cidades;
    });
  }

  Future<void> _carregarPessoas() async {
    final pessoas = await PessoaDAO().consultarTodos();
    setState(() {
      _pessoasOpcoes = pessoas;
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _bairroController.dispose();
    _logradouroController.dispose();
    _numeroController.dispose();
    _areaController.dispose();
    _precoController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _salvar() async {
    final formValido = _formKey.currentState?.validate() ?? false;
    if (formValido) {
      if (_cidadesSelecionadas == null || _cidadesSelecionadas!.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecione uma cidade válida!')),
      );
      return;
    }

      try {
        final casa = CasaDTO(
          nome: _nomeController.text.trim(),
          cidadeId: _cidadesSelecionadas!.id!,
          bairro: _bairroController.text.trim(),
          logradouro: _logradouroController.text.trim(),
          numero: int.tryParse(_numeroController.text.trim()) ?? 0,
          ativa: _ativo,
          tipo: _tipoSelecionado ?? '',
          area: double.tryParse(_areaController.text.trim()) ?? 0.0,
          preco:
              double.tryParse(
                _precoController.text
                    .trim()
                    .replaceAll('R\$', '')
                    .replaceAll('.', '')
                    .replaceAll(',', '.'),
              ) ??
              0.0,
          descricao:
              _descricaoController.text.trim().isEmpty
                  ? null
                  : _descricaoController.text.trim(),
          usuarios: null,
        );
        await CasaDao().salvar(casa);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Casa salva com sucesso!')),
        );

        //Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao salvar casa: $e')));
        print('Erro ao salvar casa: $e');
      }
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
              EntradaTexto(
                controller: _nomeController,
                label: 'Nome da casa',
                validator: ValidadorBuilder().obrigatorio().build(),
              ),
              EntradaSelect<CidadeDTO>(
                opcoes: _cidadesOpcoes,
                valorSelecionado: _cidadesSelecionadas,
                rotulo: 'Cidade',
                validator: ValidadorBuilder().obrigatorioObjeto,
                textoPadrao: 'Selecione uma cidade',
                onChanged: (cidade) {
                  setState(() {
                    _cidadesSelecionadas = cidade;
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
              BotaoInterruptor(
                label: "Ativo?",
                value: _ativo,
                onChanged: (novoValor) {
                  setState(() {
                    _ativo = novoValor;
                  });
                },
              ),
              EntradaOpcao(
                rotulo: 'Tipo',
                opcoes: tiposImoveis,
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
              CampoBuscaMultipla<PessoaDTO>(
                opcoes: _pessoasOpcoes,
                rotulo: 'Usuários',
                textoPadrao: 'Selecione um ou mais usuários',
                onChanged: (usuarios) {
                  setState(() {
                    _pessoasSelecionadas = usuarios;
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
