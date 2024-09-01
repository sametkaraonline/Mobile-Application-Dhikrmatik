import 'package:dhikrmatic/deneme3.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:dhikrmatic/db_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dhikrmatic/db_test.dart';

import 'deneme1.dart';
List<Map<String, dynamic>> _zikirler_data = [];

bool _isLoading = true;
// This function is used to fetch all data from the database
void _refreshJournals() async {
  final data = await SQLHelper.getItems();
  print(data);
   _zikirler_data = data;
   _isLoading = false;

  for (final i in _zikirler_data){
    List b = i.values.toList();
    zikirlerrrr[b[1]] = int.parse(b[2]);
  }
  //print(_zikirler_data);
}

Future<void> _addItem(a,b) async {
  await SQLHelper.createItem(
      a, b);
  _refreshJournals();
}

Future<void> _updateItem(name,descrption) async {
  await SQLHelper.updateItem(
      0,name,descrption);
  _refreshJournals();
}

// Delete an item
void _deleteItem(name) async {
  print("buraya geldi");
  await SQLHelper.deleteItem(name);
  _refreshJournals();
}


//----------------------------------------------------
List<Map<String, dynamic>> sureler = [];

// This function is used to fetch all data from the database
void _refreshJournals2() async {
  final data = await SQLHelper2.getItems();
  sureler = data;
  _isLoading = false;

  for (final i in sureler){
    List b = i.values.toList();
    surelerrrrrrr[b[1]] = int.parse(b[2]);
  }

}

Future<void> _addItem2(a,b) async {
  print("geliyor");
  await SQLHelper2.createItem(
      a, b);
  _refreshJournals();
}

// Update an existing journal
Future<void> _updateItem2(name,descrption) async {
  //await SQLHelper2.updateItem(
      //0,zikir,descrption);
  //_refreshJournals();
}

// Delete an item
void _deleteItem2(name) async {
  print("buraya geldi");
  await SQLHelper2.deleteItem(name);
  _refreshJournals();
}

// indexi id yerine kullanabilirim

final Map<String,int> zikirlerrrr = {};

final Map<String,int> surelerrrrrrr = {};



class reporosopty extends ChangeNotifier {


  late bool acil;
// This function is used to fetch all data from the database

  void getir() {
    _refreshJournals();
  }
  void getir2() {
    _refreshJournals2();
  }


  Map zikirler = zikirlerrrr;
  Map zikir_sureleri = surelerrrrrrr;
  int index = 0;
  double progressValue = 0;

  void zikir_ekle( zikir, sayi) {
    // eğer zikir varsa sayının üstüne eklesin.
    if (zikir == null){
      zikir = "İsimsiz zikir";
    }

    if (zikirler.containsKey(zikir)){
      _updateItem(zikir, sayi.toString());
        print("geldi1");
    }else{
      _addItem(zikir, sayi.toString());
      print("geldi2");
    }
    zikirler[zikir] = sayi;
    notifyListeners();
    _refreshJournals();

  }
  void zikir_suresi_ekle(zikir, sayi) {
    // eğer zikir varsa sayının üstüne eklesin.
    zikir_sureleri[zikir] = sayi;
    _addItem2(zikir, sayi.toString());
    notifyListeners();
    _refreshJournals2();
  }

  void zikri_sil(key,id) {
    print(id);
    _deleteItem(key);
    zikirler.remove(key);
    zikirlerrrr.remove(key);

    notifyListeners();
  }
  void zikirEkle(a,b) {
    zikir_ekle(a, int.parse(b.text));
      notifyListeners();
  }
  notifyListeners();
}

final zikir_provider = ChangeNotifierProvider((ref) => reporosopty());