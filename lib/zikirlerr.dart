import 'package:dhikrmatic/butonlu_sayac..dart';
import 'package:dhikrmatic/main.dart';
import 'package:dhikrmatic/zikirler_reporository.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'deneme1.dart';



class yeniiPhone13mini1 extends ConsumerWidget {

  yeniiPhone13mini1({Key? key,}) : super(key: key);

  late String deger;

  final List degerler = [];

  final myController = TextEditingController();
  final myController2 = TextEditingController();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final zikirs = ref.watch(zikir_provider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.cyan,),
        ),
        elevation: 2,
        backgroundColor: Colors.white,
        title:  Text("ZİKİRLERİM",
        style: TextStyle(
          fontFamily: "Pacifico",
          color: Colors.cyan
        ),),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          showDialog(
              context: context,
              builder: (ctxt) => AlertDialog(
                title: const Text('Zikir Ekle',
                  style: TextStyle(
                      fontFamily: "Pacifico"),),
                content: SizedBox(
                  height: 145,
                  child: Column(
                    children: [
                      TextField(
                        controller: myController,
                        maxLines: 1,
                          style: TextStyle(
                            fontFamily: "Pacifico",
                          ),
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(
                              ),
                              labelText: "Zikir İsmi:",
                              labelStyle: TextStyle(
                                fontFamily: "Pacifico",
                                color: Colors.white,
                              )
                          )
                      ),
                      TextField(
                          controller: myController2,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                        style: TextStyle(
                          fontFamily: "Pacifico",
                        ),
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Zikir Sayısı:",
                              labelStyle: TextStyle(
                                fontFamily: "Pacifico",
                                color: Colors.white,
                              )
                          )
                      ),
                    ],
                  ),
                ),
                shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ) ,
                backgroundColor: Colors.cyan,
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      zikirs.zikirEkle(myController.text,myController2);
                      myController.clear();
                      myController2.clear();
                      Navigator.of(context, rootNavigator: true).pop('dialog');

                      } ,
                    child: const Text('Ekle',
                      style: TextStyle(fontFamily: "Pacifico",
                          color: Colors.white),),
                  ),
                ],
              ),
          );
        },
        tooltip: 'Zikir Ekle',
        child: const Icon(Icons.library_add,color: Colors.white,),
      ),

      body: Column(
        children: [
          Expanded(
            // BURADA LİSTTİLE BASTIĞINDA O EKRANA YÖNLENDİRMEKİ
            //BUTONA GEREK YOK ONUN YERİNE SAYI KOYARIM
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: zikirs.zikirler.length,
              itemBuilder: (BuildContext context, int index) {
                deger = zikirs.zikirler.keys.toList()[index];
                zikirs.index = index;
                degerler.add(index);
                return Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyApp(zikirismi:zikirs.zikirler.keys.toList()[index])));
                    },
                    child: SizedBox(
                          width: 120,
                          height: 120,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.cyan,
                                  borderRadius: BorderRadius.circular(39.0),
                                  border: Border.all(width: 1.0, color: Colors.cyan),
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [SizedBox(
                                          width: 60,
                                          child: Icon(Icons.favorite,
                                            color: Colors.red,
                                            size: 30,
                                          )),
                                      ]),
                                  Expanded(
                                    child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                string_getir(deger),
                                                style: TextStyle(
                                                fontFamily: "Pacifico",
                                                color: Colors.white,
                                                fontSize: 28,
                                              ),
                                                //UZUN BİR ZİKİR İSMİ OLDUĞUNDA İYİ GÖRÜNMESİ LAZIM
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  sayi_getir(zikirs.zikirler[deger].toString()),
                                                  style: TextStyle(
                                                    fontFamily: "Pacifico",
                                                    color: Colors.white,
                                                    fontSize: 30,
                                                  ),)
                                              ],
                                            ),
                                        ]),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons.restore_from_trash_outlined,
                                                      color: Colors.red,
                                                      size: 30,
                                                    ), onPressed: () => showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) => AlertDialog(
                                                      title: const Text('Uyarı',
                                                        style: TextStyle(
                                                            fontFamily: "Pacifico"),),
                                                      content: const Text('Bu zikri silmek istediğinize emin misiniz?',
                                                        style: TextStyle(fontFamily: "Pacifico",
                                                            color: Colors.white),
                                                      ),
                                                      shape:RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(30))
                                                      ) ,
                                                      backgroundColor: Colors.cyan,
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            zikirs.zikri_sil(zikirs.zikirler.keys.toList()[index],index);
                                                            Navigator.pop(context, 'Evet');
                                                          },
                                                          child: const Text('Evet',
                                                            style: TextStyle(fontFamily: "Pacifico",
                                                                color: Colors.white),),
                                                        ),
                                                        TextButton(
                                                          onPressed: () => Navigator.pop(context, 'Hayır'),
                                                          child: const Text('Hayır',
                                                            style: TextStyle(fontFamily: "Pacifico",
                                                                color: Colors.white),),
                                                        ),
                                                      ],
                                                    ),
                                                  ),),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
          ),
        ],
      ),
    );
  }
}

sayi_getir(a) {
  if (a.length<=14){
    return a.substring(0,a.length);
  }else{
    return a.substring(0,14);
  }

}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);


string_getir(a) {
  if (a != null){
    if (a.contains("\n")){
      a = a.replaceAll("\n"," ");
    }
  }
  if (a != null){
    a = capitalize(a.toLowerCase());
  }
  if (a.length<=14){
    return a.toString().substring(0,a.length);
  }else{
    return a.toString().substring(0,14) + "...";
  }
}

const String _svg_dghf =
    '<svg viewBox="29.4 117.0 29.3 27.0" ><path transform="translate(26.0, 112.5)" d="M 18 31.5 L 15.87909317016602 29.58672714233398 C 8.347359657287598 22.67170333862305 3.375 18.18351554870605 3.375 12.59261703491211 C 3.375 8.031164169311523 6.884859561920166 4.5 11.41874980926514 4.5 C 13.97805404663086 4.5 16.39103889465332 5.67717170715332 18 7.590023517608643 C 19.60889053344727 5.67717170715332 22.02180480957031 4.5 24.58124923706055 4.5 C 29.11514091491699 4.5 32.625 8.031164169311523 32.625 12.59261703491211 C 32.625 18.18358612060547 27.6525707244873 22.67177200317383 20.12090682983398 29.58672714233398 L 18 31.5 Z" fill="#dd4c4c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_in43 =
    '<svg viewBox="318.6 113.1 34.9 34.9" ><path transform="translate(318.0, 112.5)" d="M 18 0.5625 C 27.6328125 0.5625 35.4375 8.3671875 35.4375 18 C 35.4375 27.6328125 27.6328125 35.4375 18 35.4375 C 8.3671875 35.4375 0.5625 27.6328125 0.5625 18 C 0.5625 8.3671875 8.3671875 0.5625 18 0.5625 Z M 9.84375 21.09375 L 18 21.09375 L 18 26.07890701293945 C 18 26.83125114440918 18.9140625 27.2109375 19.44140625 26.67656326293945 L 27.47812461853027 18.59765625 C 27.80859375 18.26718711853027 27.80859375 17.73984336853027 27.47812461853027 17.40937423706055 L 19.44140625 9.323436737060547 C 18.90703201293945 8.789061546325684 18 9.16874885559082 18 9.921092987060547 L 18 14.90625 L 9.84375 14.90625 C 9.379687309265137 14.90625 9 15.28593730926514 9 15.75 L 9 20.25 C 9 20.71406173706055 9.379687309265137 21.09375 9.84375 21.09375 Z" fill="#ffdfdf" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
