import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:dhikrmatic/zikirler_reporository.dart';
import 'package:dhikrmatic/settings2.dart';
import 'dart:async';
import 'package:sizer/sizer.dart';


class gauge2 extends ConsumerStatefulWidget {
  const gauge2({Key? key,this.zikir}) : super(key: key);

  final zikir;
  @override
  ConsumerState<gauge2> createState() => _gauge2State(zikir);
}

class _gauge2State extends ConsumerState<gauge2> {


  double progressValue = 0;
  int sayac = 0;

  int sure = 1000000;

  var zikir;

  var a = false;

  _gauge2State(this.zikir);

  Timer? timer;

  bool is_playing = false;
  final myController3 = TextEditingController();

  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      myController3.text =zikir;
      final zikirs = ref.watch(zikir_provider);
      if (zikir == "İsimsiz Zikir"){
        setState((){});
        myController3.text = zikirs.zikirler.keys.toList().last;
        progressValue = zikirs.zikirler.values.toList().last.toDouble();
        if (progressValue > 99){
          sayac = (progressValue/99).toInt();
          progressValue = progressValue%99;
        }
      }else{
        setState((){
          progressValue = zikirs.zikirler[zikir]!.toDouble();
          if (progressValue > 99){
            sayac = (progressValue/99).toInt();
            progressValue = progressValue%99;
          }
        });
      }
    });
    // Step 2 <- SEE HERE
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zikirs = ref.watch(zikir_provider);

    if(zikirs.zikir_sureleri[zikir] != null){
      sure = zikirs.zikir_sureleri[zikir]!;
    }

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top:7
            ),
            child: SizedBox(
              width: 100.w,
              height: 18.h,
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: buildTextField(),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 100.w,
              height: 40.h,
              child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 0,
                      maximum: 99,
                      showLabels: false,
                      showTicks: false,
                      startAngle: 270,
                      endAngle: 270,
                      annotations:<GaugeAnnotation>[
                        GaugeAnnotation(
                            positionFactor: 0.1,
                            angle: 90,
                            widget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 50.sp,
                                  child: Text(
                                    progressValue.toStringAsFixed(0),
                                    style: TextStyle(fontSize: 35.sp,fontFamily: "Pacifico",color: Colors.cyan),
                                  ),
                                ),
                                Text(
                                  sayac.toString(),
                                  style: TextStyle(fontSize: 20.sp,fontFamily: "Pacifico",color: Colors.cyan),
                                ),
                              ],
                            ))
                      ],
                      axisLineStyle: AxisLineStyle(
                        thickness: 0.10,
                        color: const Color.fromARGB(100, 0, 169, 181),
                        thicknessUnit: GaugeSizeUnit.factor,
                      ),
                      pointers: <GaugePointer>[

                        RangePointer(
                            value: progressValue,
                            width: 0.1,
                            sizeUnit: GaugeSizeUnit.factor,
                            color: Renk(),
                            cornerStyle: CornerStyle.bothCurve),

                        MarkerPointer(
                          markerHeight: 25,
                          markerWidth: 25,
                          value: progressValue,
                          markerType: MarkerType.circle,
                          color: Renk(),
                        )
                      ],
                    )
                  ]
              ),
            ),
          ),
          SizedBox(
            height:10.sp ,
            width: 25.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 45.sp,
                height: 45.sp,
                child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StopwatchPage(zikir: myController3.text)));
                  },
                  child: Icon(Icons.access_time,size: 20.sp,color: Colors.white,),
                ),
              ),
              SizedBox(
                width: 30.sp,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                  shape: MaterialStateProperty.all(CircleBorder()),
                  padding: MaterialStateProperty.all(EdgeInsets.all(25.sp)),
                  backgroundColor: MaterialStateProperty.all(Colors.cyan), // <-- Button color
                  overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed)) return Colors.cyan.shade700; // <-- Splash color
                  }),
                  ),
                  onPressed: () {
                  zaman();
                  kaydet(zikirs);
                },
                //Zamanı durdurunca İCONUN DEĞİŞMESİ GEREK ...
                child: Ikon_getir(is_playing)
              ),
              SizedBox(
                width: 30.sp,
              ),
              SizedBox(
                width: 45.sp,
                height: 45.sp,
                child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Uyarı',
                            style: TextStyle(
                                fontFamily: "Pacifico"),),
                          content: const Text('Sayacı sıfırlamak istediğinize emin misiniz?',
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
                                setState(() {
                                  zikirs.zikirler[zikir] =0;
                                  progressValue = 0;
                                  sayac = 0;
                                });
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
                        ));
                    //Kaydetme zikir listesine eklicek.
                  },
                  child: Icon(Icons.restart_alt,size: 20.sp,color: Colors.white,),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  void kaydet(reporosopty zikirs) {
    if (myController3.text.isEmpty) {
      zikirs.zikir_ekle("İsimsiz Zikir", progressValue.toInt() + sayac * 99);
    }else{
      zikirs.zikir_ekle(myController3.text, progressValue.toInt() + sayac * 99);
    }
  }

  void zaman() {
    if (is_playing == false) {
      is_playing = true;
      setState((){
      });
      print(is_playing);
      print("asd");
      timer = Timer.periodic(
        Duration(microseconds: sure),
              (timer){
            setState(() {
              print(sure);
                progressValue++;
                if (progressValue == 100) {
                  sayac = sayac + 1;
                  progressValue = 1;
                }
              }
            );
          },
        );
    }else{
      print(is_playing);
      print(sure);
      print("asdasdsad");
      setState(() {
        timer?.cancel();
        });
      is_playing = false;
    }
  }
  Renk() {
    if (progressValue <= 33) {
      return Colors.cyan.shade500;
    }
    if(progressValue >= 33  && progressValue <= 66){
      return Colors.cyan.shade600;
    }
    if(progressValue >= 66){
      return Colors.cyan.shade700;
    }
  }

  Icon Ikon_getir(is_playing) {
    if (is_playing == false) {
       return Icon(Icons.play_arrow, size: 20.sp, color: Colors.white,);
  }else{
      return Icon(Icons.pause,size: 20.sp,color: Colors.white,);
    }
  }

  buildTextField() {
    if(zikir != "İsimsiz Zikir"){
      return SingleChildScrollView(
        child: Text(
          zikir,style: TextStyle(
          fontFamily: "Pacifico",
          color: Colors.cyan,
        ),
        ),
      );
    }else{


      if(zikir == "İsimsiz Zikir"){setState((){
      });}

      return TextField(
        //expands: true,
        //keyboardType: TextInputType.multiline,
        maxLines: 1,
        controller: myController3,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.cyan, width: 0.0),
          ),
          border: OutlineInputBorder(),
          labelText: "Zikir:",
          labelStyle: TextStyle(
            color: Colors.cyan, //<-- SEE HERE
          ),
        ),
        style: TextStyle(
          fontFamily: "Pacifico",
          color: Colors.cyan,
        ),
      );

    }
  }

}
