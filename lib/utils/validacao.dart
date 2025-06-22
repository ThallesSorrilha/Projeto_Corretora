typedef Validador = String? Function(String? value);

class ValidadorBuilder {
  final List<Validador> _validadores = [];

  String? obrigatorioObjeto<T>(T? value) {
    if (value == null) {
      return 'Campo obrigatório';
    }
    return null;
  }

  ValidadorBuilder obrigatorio([String mensagem = 'Campo obrigatório']) {
    _validadores.add((value) {
      if (value == null || value.trim().isEmpty) return mensagem;
      return null;
    });
    return this;
  }

  ValidadorBuilder email([String mensagem = 'E-mail inválido']) {
    _validadores.add((value) {
      if (value == null) return null;
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
      if (!emailRegex.hasMatch(value)) return mensagem;
      return null;
    });
    return this;
  }

  ValidadorBuilder max(num max, [String? mensagem]) {
    _validadores.add((value) {
      final n = num.tryParse(value ?? '');
      if (n == null) return null;
      if (n > max) return mensagem ?? 'O valor deve ser no máximo $max';
      return null;
    });
    return this;
  }

  ValidadorBuilder min(num min, [String? mensagem]) {
    _validadores.add((value) {
      final n = num.tryParse(value ?? '');
      if (n == null) return null;
      if (n < min) return mensagem ?? 'O valor deve ser no mínimo $min';
      return null;
    });
    return this;
  }

  ValidadorBuilder inteiro([String mensagem = 'O valor deve ser inteiro']) {
    _validadores.add((value) {
      final n = num.tryParse(value ?? '');
      if (n == null) return null;
      if (n is! int && n != n.roundToDouble()) return mensagem;
      return null;
    });
    return this;
  }

  ValidadorBuilder positivo([String mensagem = 'O valor deve ser positivo']) {
    _validadores.add((value) {
      final n = num.tryParse(value ?? '');
      if (n == null) return null;
      if (n <= 0) return mensagem;
      return null;
    });
    return this;
  }

  String? call(String? value) {
    for (final validador in _validadores) {
      final erro = validador(value);
      if (erro != null) return erro;
    }
    return null;
  }
}

// Extension para facilitar o uso
extension ValidadorExt on ValidadorBuilder {
  Validador build() => call;
}
