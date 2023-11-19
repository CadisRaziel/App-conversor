import 'package:api_cotacao/src/models/moeda_model.dart';
import 'package:api_cotacao/src/repositories/moeda_repository.dart';
import 'package:api_cotacao/src/states/moeda_state.dart';
import 'package:flutter/material.dart';


class MoedaController extends ValueNotifier<MoedaState> {
  final repository = MoedaRepository();

  MoedaController() : super(MoedaState.init()); //-> sempre que uso o valueNotifier preciso passar um estado inicial, por isso o construtor .init

  Future<void> getMoedas() async {
    final moedas = await repository.getMoedas();

    value = value.copyWith(moedas: moedas);
  }

  Future<void> converter(String valorRaw) async {
    final cotacao = await repository.cotacao(value.moedaIn, value.moedaOut);

    final valor = double.parse(valorRaw);
    final resultado = valor * cotacao;

    value = value.copyWith(result: resultado.toStringAsFixed(2));
  }

  Future<void> selecionarMoedaIn(MoedaModel model) async {
    value = value.copyWith(moedaIn: model);
  }

  Future<void> selecionarMoedaOut(MoedaModel model) async {
    value = value.copyWith(moedaOut: model);
  }

  void switchMoedas() {
    value = value.copyWith(
      moedaIn: value.moedaOut,
      moedaOut: value.moedaIn,
    );
  }
}