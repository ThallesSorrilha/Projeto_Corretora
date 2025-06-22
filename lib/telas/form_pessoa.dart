import 'package:flutter/material.dart';
import 'package:projeto_corretora/componentes/app_bar_salvar.dart';
import 'package:projeto_corretora/componentes/entrada_select.dart';
import 'package:projeto_corretora/componentes/entrada_texto.dart';
import 'package:projeto_corretora/dto/dto.dart';
import 'package:projeto_corretora/utils/personalizacao_formulario.dart';
import 'package:projeto_corretora/utils/validacao.dart';

class Cidade extends DTO {
  Cidade({required super.id, required super.nome});
}

class Usuario extends DTO {
  Usuario({required super.id, required super.nome});
}

List<Cidade> selectCidades = [
  Cidade(id: 1, nome: 'Navegantes'),
  Cidade(id: 2, nome: 'Florianópolis'),
  Cidade(id: 3, nome: 'Curitiba'),
  Cidade(id: 4, nome: 'Maringá'),
  Cidade(id: 5, nome: 'Ouro Preto'),
  Cidade(id: 6, nome: 'Belo Horizonte'),
];

List<Usuario> selectUsuarios = [
  Usuario(id: 1, nome: 'Cleiton'),
  Usuario(id: 2, nome: 'Jorge'),
  Usuario(id: 3, nome: 'Betinho'),
  Usuario(id: 4, nome: 'Cleonice'),
  Usuario(id: 5, nome: 'Florentina'),
  Usuario(id: 6, nome: 'Zazá'),
];

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

  final List<Cidade> _cidadeOpcoes = selectCidades;

  Cidade? _cidadeSelecionada;

  @override
  void dispose() {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _salvar() {
    final formValido = _formKey.currentState?.validate() ?? false;
    if (formValido) {
      final usuarioData = {
        'nome': _nomeController.text.trim(),
        'sobrenome': _sobrenomeController.text.trim(),
        'telefone': _telefoneController.text.trim(),
        'email': _emailController.text.trim(),
        'cidade': _cidadeSelecionada,
      };

      //...
      print('Usuário salvo: $usuarioData');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário salvo com sucesso!')),
      );

      //Navigator.of(context).pop();
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
              ElevatedButton(onPressed: _salvar, child: Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}
