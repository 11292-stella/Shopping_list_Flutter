import 'package:flutter/material.dart';
// Import del widget principale che mostra la lista della spesa.
// Questo file contiene la UI iniziale dell’app.
import 'package:shopping_list/widgets/grocery_list.dart';

void main() {
  // runApp() avvia l’app Flutter.
  // Gli passiamo MyApp(), che è il widget radice dell’intera applicazione.
  runApp(const MyApp());
}

// MyApp è il widget principale dell’app.
// Estende StatelessWidget perché non ha stato interno: configura solo tema e home.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Questo widget è la radice dell’applicazione.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Titolo dell’app (usato da Android per il task switcher).
      title: 'Flutter Groceries',

      // Tema globale dell’app.
      // ThemeData.dark() crea un tema base scuro.
      // copyWith() permette di sovrascrivere solo alcune parti del tema.
      theme: ThemeData.dark().copyWith(
        // Attiva Material Design 3 (M3), la versione più moderna del design system.
        useMaterial3: true,

        // ColorScheme è la palette di colori principale dell’app.
        // fromSeed genera automaticamente una palette completa partendo da un solo colore.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 147, 229, 250),
          brightness: Brightness.dark, // palette ottimizzata per dark mode
          surface: const Color.fromARGB(
            255,
            42,
            51,
            59,
          ), // colore superfici (card, appbar, ecc.)
        ),

        // Colore di sfondo globale di tutte le schermate (Scaffold).
        scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
      ),

      // Primo widget mostrato all’avvio dell’app.
      // GroceryList è la schermata principale che mostra la lista della spesa.
      home: const GroceryList(),
    );
  }
}
