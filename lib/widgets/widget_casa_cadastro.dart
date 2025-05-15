import 'package:flutter/material.dart';
import 'package:projeto_corretora/widgets/componentes/widget_botao_icone_desc.dart';
import 'package:projeto_corretora/widgets/componentes/widget_icone_desc.dart';

class WidgetCasaCadastro extends StatefulWidget {
  @override
  _WidgetCasaCadastro createState() => _WidgetCasaCadastro();
}

class _WidgetCasaCadastro extends State<WidgetCasaCadastro> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Casa')),
      body: Center(
        child: Container(
          width: 400,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Form(
                key: _formKey,
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Card(
                      color: const Color(0xFFEDEFEC),
                      child: Column(
                        children: [
                          WidgetIconeDesc(icone: Icons.map, descricao: "Local"),
                          // estado
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Estado',
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: '1',
                                child: Text('PARANÁ'),
                              ),
                              DropdownMenuItem(
                                value: '2',
                                child: Text('SÃO PAULO'),
                              ),
                              DropdownMenuItem(
                                value: '3',
                                child: Text('SANTA CATARINA'),
                              ),
                            ],
                            onChanged: (value) {},
                          ),
                          // cidade
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Cidade',
                              hintText: 'Ex: Paranavaí',
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Cidade não deve ser nula';
                              }
                            },
                          ),
                          // bairro
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Bairro',
                              hintText: 'Ex: Centro',
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Bairro não deve ser nulo';
                              }
                            },
                          ),
                          // Logradouro
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Logradouro',
                              hintText: 'Ex: Rua Getúlio Vargas',
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Logradouro não deve ser nulo';
                              }
                            },
                          ),
                          // número
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Número',
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Número não deve ser nula';
                              }
                            },
                          ),
                          SizedBox(height: 8),
                          WidgetIconeDesc(
                            icone: Icons.home,
                            descricao: "Tipo de Casa",
                          ),
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Tipo',
                            ),
                            items: const [
                              DropdownMenuItem(value: '1', child: Text('Casa')),
                              DropdownMenuItem(
                                value: '2',
                                child: Text('Apartamento'),
                              ),
                              DropdownMenuItem(
                                value: '3',
                                child: Text('Terreno'),
                              ),
                            ],
                            onChanged: (value) {},
                          ),
                          SizedBox(height: 8),
                          WidgetIconeDesc(
                            icone: Icons.area_chart_rounded,
                            descricao: "Área",
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'área',
                              hintText: '(m2)',
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Cidade não deve ser nula';
                              }
                            },
                          ),
                          WidgetIconeDesc(
                            icone: Icons.money,
                            descricao: "Preço",
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'preço',
                              hintText: 'R\$  ,00',
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Cidade não deve ser nula';
                              }
                            },
                          ),
                          SizedBox(height: 10),
                          WidgetBotaoDescricao(
                            icone: Icons.send,
                            descricao: "Cadastrar",
                            pressionado: () {
                              if (_formKey.currentState!.validate()) {
                                print('deu certo');
                              } else {
                                print('erro');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
