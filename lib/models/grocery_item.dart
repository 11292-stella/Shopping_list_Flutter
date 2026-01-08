import 'package:shopping_list/models/category.dart';

/// Modello che rappresenta un singolo elemento della lista della spesa.
/// È una semplice classe immutabile (tutte le proprietà sono final).
///
/// Perché un modello?
/// - Mantiene i dati organizzati
/// - Facilita il passaggio di informazioni tra schermate
/// - Evita errori: ogni GroceryItem ha SEMPRE id, nome, quantità e categoria
///
/// Questo modello viene creato nella schermata NewItem e poi passato
/// alla GroceryList tramite Navigator.pop().
class GroceryItem {
  /// Costruttore const:
  /// - permette di creare istanze immutabili
  /// - ottimizza le prestazioni (Flutter può memorizzarle in modo efficiente)
  const GroceryItem({
    required this.id, // Identificatore univoco dell’item
    required this.name, // Nome dell’elemento (es. "Pomodori")
    required this.quantity, // Quantità (es. 3)
    required this.category, // Categoria (es. Vegetables)
  });

  /// ID univoco dell’item.
  /// Viene generato nella schermata NewItem usando DateTime.now().toString()
  /// oppure potresti usare uuid per maggiore robustezza.
  final String id;

  /// Nome dell’elemento della spesa.
  final String name;

  /// Quantità dell’elemento.
  final int quantity;

  /// Categoria dell’elemento (oggetto Category).
  /// Contiene colore e titolo della categoria.
  final Category category;
}
