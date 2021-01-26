import 'dart:async';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


final String TabelaContato = "TabelaContato";
final String ColunaId = "ColunaId";
final String ColunaNome = "ColunaNome";
final String ColunaEmail = "ColunaEmail";
final ColunaTelefone = "ColunaTelefone";
final ColunaImg = "ColunaImg";

class ContatoAjuda {
  static final ContatoAjuda _instance = ContatoAjuda.interno();

  factory ContatoAjuda() => _instance;

  ContatoAjuda.interno();

  Database _db; // Banco de dados

 Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db =  await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final DatabasesPath = await getDatabasesPath();
    final path = join(DatabasesPath, "Contatos.db");
      return await openDatabase(path, version: 1, onCreate:(Database db, int newrVersion) async {
      await db.execute(
        "CREATE TABLE $TabelaContato($ColunaId INTEGER PRIMARY KEY, $ColunaNome TEXT, $ColunaEmail TEXT,"
            "$ColunaTelefone TEXT, $ColunaImg TEXT)"
      );
    });
  }

   Future<Database> saveContato(Contato contato) async {
    Database dbContato = await db;
    contato.id = await dbContato.insert(TabelaContato, contato.paraMap());
    return Contato;
  }

  Future<Contato>
}

class Contato {
  int id;
  String nome;
  String email;
  String telefone;
  String img;

  Contato.deMap(Map map) {
    id = map[ColunaId];
    nome = map[ColunaNome];
    email = map[ColunaEmail];
    telefone = map[ColunaTelefone];
    img = map[ColunaImg];
  }

  Map paraMap() {
    Map<String, dynamic> map = {
      ColunaNome: nome,
      ColunaEmail: email,
      ColunaTelefone: telefone,
      ColunaImg: img
    };

    if (id != null) {
      map[ColunaId] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contato ( id:$id, nome: $nome, email: $email, telefone: $telefone, img: $img)";
  }
}
