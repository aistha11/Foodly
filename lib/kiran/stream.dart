import 'dart:async';
import 'package:foodapp/kiran/models.dart';

class CartStream implements Core {
  StreamController<List<Foodly>> _streamController =
      StreamController<List<Foodly>>.broadcast();
  Stream<List<Foodly>> get stream => _streamController.stream;
  Sink<List<Foodly>> get sink => _streamController.sink;

  @override
  void dispose() => _streamController?.close();
}

abstract class Core {
  void dispose();
}
