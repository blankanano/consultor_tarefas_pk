import 'package:flutter_test/flutter_test.dart';
import 'package:consultor_tarefas_pk/consultor_tarefas_pk.dart';

void main() {
  group('Tarefa', () {
    test('construtor deve criar uma tarefa corretamente', () {
      final tarefa =
          Tarefa('Comprar mantimentos', DateTime.now(), 'Supermercado');

      expect(tarefa.nome, 'Comprar mantimentos');
      expect(tarefa.dataHora, isNotNull);
      expect(tarefa.localizacao, 'Supermercado');
    });

    test('fromJson deve converter um mapa para uma instância de Tarefa', () {
      final json = {
        'id': '1',
        'nome': 'Ler livro',
        'dataHora': '2023-06-01T10:30:00Z',
        'localizacao': 'Biblioteca',
      };

      final tarefa = Tarefa.fromJson(json);

      expect(tarefa.id, '1');
      expect(tarefa.nome, 'Ler livro');
      expect(tarefa.dataHora, DateTime.parse('2023-06-01T10:30:00Z'));
      expect(tarefa.localizacao, 'Biblioteca');
    });

    test('toJson deve converter uma instância de Tarefa para um mapa', () {
      final tarefa =
          Tarefa('Estudar programação', DateTime(2023, 7, 1), 'Casa');

      final json = tarefa.toJson();

      expect(json['nome'], 'Estudar programação');
      expect(json['dataHora'], '2023-07-01T00:00:00.000');
      expect(json['localizacao'], 'Casa');
    });

    test(
        'listFromJson deve converter um mapa de tarefas para uma lista de Tarefa',
        () {
      final json = {
        '1': {
          'nome': 'Fazer exercícios',
          'dataHora': '2023-06-02T14:00:00Z',
          'localizacao': 'Academia',
        },
        '2': {
          'nome': 'Fazer compras',
          'dataHora': '2023-06-03T09:30:00Z',
          'localizacao': 'Supermercado',
        },
      };

      final tarefas = Tarefa.listFromJson(json);

      expect(tarefas.length, 2);
      expect(tarefas[0].id, '1');
      expect(tarefas[0].nome, 'Fazer exercícios');
      expect(tarefas[0].dataHora, DateTime.parse('2023-06-02T14:00:00Z'));
      expect(tarefas[0].localizacao, 'Academia');
      expect(tarefas[1].id, '2');
      expect(tarefas[1].nome, 'Fazer compras');
      expect(tarefas[1].dataHora, DateTime.parse('2023-06-03T09:30:00Z'));
      expect(tarefas[1].localizacao, 'Supermercado');
    });

    test('toJson deve incluir o ID da tarefa quando disponível', () {
      final tarefa =
          Tarefa('Estudar programação', DateTime(2023, 7, 1), 'Casa');
      tarefa.id = '1';

      final json = tarefa.toJson();

      expect(json['id'], '1');
      expect(json['nome'], 'Estudar programação');
      expect(json['dataHora'], '2023-07-01T00:00:00.000');
      expect(json['localizacao'], 'Casa');
    });

    test('toJson não deve incluir o ID da tarefa quando indisponível', () {
      final tarefa =
          Tarefa('Estudar programação', DateTime(2023, 7, 1), 'Casa');

      final json = tarefa.toJson();

      expect(json.containsKey('id'), false);
      expect(json['nome'], 'Estudar programação');
      expect(json['dataHora'], '2023-07-01T00:00:00.000');
      expect(json['localizacao'], 'Casa');
    });

    test(
        'listFromJson deve retornar uma lista vazia em caso de erro na conversão',
        () {
      final json = {
        '1': {
          'nome': 'Fazer exercícios',
          'dataHora': '2023-06-02T14:00:00Z',
          // Localização ausente
        },
      };

      final tarefas = Tarefa.listFromJson(json);

      expect(tarefas.length, 0);
    });
  });
}
