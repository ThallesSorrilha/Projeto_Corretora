import 'package:flutter/material.dart';
import 'package:projeto_corretora/componentes/app_bar_salvar.dart';
import 'package:projeto_corretora/componentes/entrada_select.dart';
import 'package:projeto_corretora/componentes/entrada_texto.dart';
import 'package:projeto_corretora/dao/dao_cidade.dart';
import 'package:projeto_corretora/dao/dao_pessoa.dart';
import 'package:projeto_corretora/dto/dto_cidade.dart';
import 'package:projeto_corretora/dto/dto_pessoa.dart';
import 'package:projeto_corretora/utils/mascaras.dart';
import 'package:projeto_corretora/utils/validacao.dart';

class FormPessoa extends StatefulWidget {
  const FormPessoa({super.key});

  @override
  State<FormPessoa> createState() => _FormPessoaState();
}

class _FormPessoaState extends State<FormPessoa> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  List<CidadeDTO> _cidadesOpcoes = [];
  CidadeDTO? _cidadesSelecionadas;

  @override
  void initState() {
    super.initState();
    _carregarCidades();
  }

  Future<void> _carregarCidades() async {
    final cidades = await CidadeDAO().consultarTodos();
    setState(() {
      _cidadesOpcoes = cidades;
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
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
      final pessoa = PessoaDTO(
        nome: _nomeController.text.trim(),
        sobrenome: _sobrenomeController.text.trim(),
        telefone: _telefoneController.text.trim(),
        email: _emailController.text.trim(),
        cidadeId: _cidadesSelecionadas!.id!, // A verificação acima garante que não é null
      );
      await PessoaDAO().salvar(pessoa);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário salvo com sucesso!')),
      );

      // Navigator.of(context).pop();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar usuário: $e')),
      );
      print('Erro ao salvar usuário: $e');
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSalvar(titulo: "Cadastrar de Usuário", aoSalvar: _salvar),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              EntradaTexto(
                controller: _nomeController,
                label: 'Nome',
                validator: ValidadorBuilder().obrigatorio().build(),
              ),
              EntradaTexto(
                controller: _sobrenomeController,
                label: 'Sobrenome',
                validator: ValidadorBuilder().obrigatorio().build(),
              ),
              EntradaTexto(
                controller: _telefoneController,
                label: 'Telefone',
                keyboardType: TextInputType.number,
                inputFormatters: [MaskUtils.telefoneMask],
                validator: ValidadorBuilder().obrigatorio().build(),
              ),
              EntradaTexto(
                controller: _emailController,
                label: 'E-mail',
                validator: ValidadorBuilder().email().build(),
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
              ElevatedButton(onPressed: _salvar, child: Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}
