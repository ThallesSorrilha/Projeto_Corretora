import 'package:flutter/material.dart';
import 'package:projeto_corretora/componentes/entrada_select.dart';
import 'package:projeto_corretora/componentes/entrada_texto.dart';
import 'package:projeto_corretora/componentes/app_bar_salvar.dart';
import 'package:projeto_corretora/dao/dao_cidade.dart';
import 'package:projeto_corretora/dto/dto_cidade.dart';
import 'package:projeto_corretora/utils/validacao.dart';
import 'package:projeto_corretora/dto/dto_estado.dart';
import 'package:projeto_corretora/dao/dao_estado.dart';

class FormCidade extends StatefulWidget {
  const FormCidade({super.key});

  @override
  State<FormCidade> createState() => _FormCidadeState();
}

class _FormCidadeState extends State<FormCidade> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();

  List<EstadoDTO> _estadosOpcoes = [];
  EstadoDTO? _estadoSelecionado;

  @override
  void initState() {
    super.initState();
    _carregarEstados();
  }

  Future<void> _carregarEstados() async {
    final estados = await EstadoDAO().consultarTodos();
    setState(() {
      _estadosOpcoes = estados;
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _salvar() async {
    final formValido = _formKey.currentState?.validate() ?? false;
    if (formValido) {
      if (_estadoSelecionado == null) {
        // This case should be caught by validator, but as a fallback:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecione um estado!')),
        );
        return;
      }
      try {
        final cidade = CidadeDTO(
          nome: _nomeController.text.trim(),
          estadoId: _estadoSelecionado!.id!,
        );
        await CidadeDAO().salvar(cidade);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cidade salva com sucesso!')),
        );

        //Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao salvar cidade: $e')));
        // Log the error for debugging:
        print('Erro ao salvar cidade: $e');
      }
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
              EntradaTexto(
                controller: _nomeController,
                label: 'Nome',
                validator: ValidadorBuilder().obrigatorio().build(),
              ),
              EntradaSelect<EstadoDTO>(
                opcoes: _estadosOpcoes,
                valorSelecionado: _estadoSelecionado,
                rotulo: 'Estado',
                validator: ValidadorBuilder().obrigatorioObjeto,
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
