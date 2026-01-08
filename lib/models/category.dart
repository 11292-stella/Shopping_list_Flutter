import 'package:flutter/material.dart';

/// Enum che rappresenta tutte le categorie disponibili.
///
/// Perché un enum?
/// - Garantisce che le categorie siano sempre una di queste (nessun errore di battitura)
/// - È facile da usare come chiave in mappe o switch
/// - È leggibile e sicuro
///
/// Questo enum viene usato come chiave nella mappa `categories`
/// per ottenere l’oggetto Category corrispondente.
enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other,
}

/// Modello che rappresenta una singola categoria.
/// Ogni categoria ha:
/// - un titolo (es. "Vegetables")
/// - un colore (usato nella UI per indicare la categoria)
///
/// Questo modello viene usato:
/// - nel dropdown della schermata NewItem
/// - per colorare il quadratino accanto al nome dell’item
/// - per rendere la UI più leggibile e organizzata
class Category {
  /// Costruttore const:
  /// - rende l’oggetto immutabile
  /// - permette ottimizzazioni interne di Flutter
  /// - garantisce che titolo e colore non cambino mai
  const Category(this.title, this.color);

  /// Nome leggibile della categoria (es. "Fruit").
  final String title;

  /// Colore associato alla categoria.
  /// Viene mostrato nella UI come piccolo quadrato colorato.
  final Color color;
}
