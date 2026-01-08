# 01 – Flusso generale dell’app (Shopping List)

## 1. Punto di ingresso: `main.dart`

- **`main()`**  
  - Chiama `runApp(const MyApp());`  
  - Avvia l’app Flutter e monta il widget radice.

- **`MyApp` (StatelessWidget)**  
  - Configura:
    - `MaterialApp`
    - tema (`ThemeData.dark().copyWith(...)`)
    - `home: const GroceryList()`
  - Non ha stato: si limita a definire aspetto e schermata iniziale.

---

## 2. Schermata principale: `GroceryList`

**File:** `widgets/grocery_list.dart` (nel tuo progetto)

- È uno **StatefulWidget** perché:
  - mantiene una lista mutabile: `List<GroceryItem> _groceryItems`
  - deve aggiornare la UI quando la lista cambia

### Stato interno

- `_groceryItems`  
  - lista di `GroceryItem`
  - inizialmente vuota
  - viene aggiornata con `setState` quando:
    - aggiungi un item
    - rimuovi un item

### AppBar

- Titolo: `"Your Groceries"`
- Icona `+`:
  - `onPressed: _addItem`
  - apre la schermata per aggiungere un nuovo elemento

### Corpo: lista dinamica

- Usa `ListView.builder`:
  - `itemCount: _groceryItems.length`
  - `itemBuilder: (ctx, index) { ... }`
- Ogni elemento:
  - è un `Dismissible` (per lo swipe to delete)
  - contiene un `ListTile` con:
    - `title`: nome dell’item
    - `leading`: quadratino colorato (categoria)
    - `trailing`: quantità

---

## 3. Aggiunta di un nuovo elemento: `NewItem`

**File:** `widgets/new_item.dart`

### Apertura della pagina

- Da `GroceryList`:

```dart
final newItem = await Navigator.of(context).push<GroceryItem>(
  MaterialPageRoute(
    builder: (ctx) => const NewItem(),
  ),
);
