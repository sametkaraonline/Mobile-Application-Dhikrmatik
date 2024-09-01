import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:dhikrmatic/db_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dhikrmatic/zikirler_reporository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:dhikrmatic/db_test.dart';


final dbHelper = DatabaseHelper.instance;


void _insert(row) async {
  // row to insert
  final name = await dbHelper.insert(row);
  print('inserted row id: $name');
}

void _query() async {
  final allRows = await dbHelper.queryAllRows();
  print('query all rows:');
  allRows.forEach(print);
}

void _update(row) async {
  // row to update
  final rowsAffected = await dbHelper.update(row);
  print('updated $rowsAffected row(s)');
}

void _delete(name) async {
  final rowsDeleted = await dbHelper.delete(name!);
  print('deleted $rowsDeleted row(s): row $name');
}







class reporosopty extends ChangeNotifier {

  int index = 0;
  double progressValue = 0;
  final Map<String,int> zikirler = {};
  final Map<String,int> zikir_sureleri = {"Elhamdülillah":78,};


  void zikir_ekle(zikir, sayi) {
    print("geldi");
    _query();

    // eğer zikir varsa sayının üstüne eklesin.
    if (zikir == null){
      zikir = "İsimsiz zikir";
    }
    zikirler[zikir] = sayi;
    notifyListeners();

    if (zikirler.containsKey(zikir)){
      _update({zikir,sayi});
    }else{
      _insert({zikir,sayi});
    }
  }
  void zikir_suresi_ekle(zikir, sayi) {
    // eğer zikir varsa sayının üstüne eklesin.
    zikir_sureleri[zikir] = sayi;
    notifyListeners();
  }

  void zikri_sil(key) {
    zikirler.remove(key);
    notifyListeners();
    _delete(key);
  }


  void zikirEkle(a,b) {
    zikir_ekle(a, int.parse(b.text));
    notifyListeners();

  }


  notifyListeners();
}

final zikir_provider = ChangeNotifierProvider((ref) => reporosopty());

