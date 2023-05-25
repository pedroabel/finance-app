import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class CustomServer {
  // Future<void> initialize(Handler handler) async {
  //   String address = 'localhost';
  //   int port = 8080;

  //   await shelf_io.serve(handler, address, port);
  //   print("Servidor: http://$address:$port");
  // }

  Future<void> initialize(Handler handler) async {
    String address = 'localhost';
    int port = 3030;

    await shelf_io.serve(handler, address, port);
    print("Servidor: http://$address:$port");
  }
}
