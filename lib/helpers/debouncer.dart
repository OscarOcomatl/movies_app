import 'dart:async';
// Creditos
// https://stackoverflow.com/a/52922130/7834829

class Debouncer<T> { // Se va a manejar un Stream

  Debouncer({ 
    required this.duration, // cantidad de tiempo que se quiere esperar antes de emitir un valor
    this.onValue // algo que se va a disparar cuando ya se tenga un valor
  });

  final Duration duration;

  void Function(T value)? onValue;

  T? _value;
  Timer? _timer;
  
  T get value => _value!;

  set value(T val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue!(_value!));
  }  
}