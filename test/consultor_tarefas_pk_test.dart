import 'package:flutter_test/flutter_test.dart';
import 'package:consultor_tarefas_pk/consultor_tarefas_pk.dart';

void main() {
  group('Tarefa', () {
    test('toJson() deve retornar um mapa válido', () {
      // Arrange
      final tarefa = Tarefa('Tarefa 1', DateTime.now(), 'Localização 1');

      // Act
      final json = tarefa.toJson();

      // Assert
      expect(json, isA<Map<String, dynamic>>());
      expect(json['nome'], equals('Tarefa 1'));
      expect(json['dataHora'], isA<String>());
      expect(json['localizacao'], equals('Localização 1'));
    });

    test(
        'fromJson() deve criar uma instância de Tarefa válida a partir de um mapa',
        () {
      // Arrange
      final json = {
        'id': '123',
        'nome': 'Tarefa 1',
        'dataHora': '2023-07-03T10:30:00Z',
        'localizacao': 'Localização 1',
      };

      // Act
      final tarefa = Tarefa.fromJson(json);

      // Assert
      expect(tarefa.id, equals('123'));
      expect(tarefa.nome, equals('Tarefa 1'));
      expect(tarefa.dataHora, equals(DateTime.parse('2023-07-03T10:30:00Z')));
      expect(tarefa.localizacao, equals('Localização 1'));
    });
  });
}
