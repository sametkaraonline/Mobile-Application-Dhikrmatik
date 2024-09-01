import 'package:dhikrmatic/main.dart';
import 'package:dhikrmatic/zikirlerr.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:dhikrmatic/zikirler_reporository.dart';
import 'package:sizer/sizer.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:dhikrmatic/settings2.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';




class sayaclar extends ConsumerStatefulWidget {
  const sayaclar({Key? key,this.zikir}) : super(key: key);

  final zikir;

  @override
  ConsumerState<sayaclar> createState() => _sayaclarState(zikir);
}

class _sayaclarState extends ConsumerState<sayaclar> {

  int sayac = 0;

  Timer? timer;

  bool is_playing = false;

  var zikir;

  int sure = 1000000;

  bool deger = true;

  final myController3 = TextEditingController();

  double progressValue = 0;

  _sayaclarState(this.zikir);

  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      myController3.text =zikir;
      final zikirs = ref.watch(zikir_provider);
      zikirs.getir();
      zikirs.getir2();
        if (progressValue > 99){
          sayac = (progressValue/99).toInt();
          progressValue = progressValue%99;
        }
      else{
        setState((){
          progressValue = zikirs.zikirler[zikir]!.toDouble();
          if (progressValue > 99){
            sayac = (progressValue/99).toInt();
            progressValue = progressValue%99;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController3.dispose();
    super.dispose();
  }


  yeniiPhone13mini1 sinif = yeniiPhone13mini1();

  @override
  Widget build(BuildContext context) {
    final zikirs = ref.watch(zikir_provider);

    if (is_playing == true){
      zikirs.acil =true;
    }

    if (is_playing == false){
      zikirs.acil =false;
    }


    if(zikirs.zikir_sureleri[myController3.text] != null){
      sure = zikirs.zikir_sureleri[myController3.text]!;
    };

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top:7
            ),
            child: SizedBox(
              width: 100.w,
              height: 16.h,
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: TextField(

                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  minLines: 1,
                  maxLines: 3,
                  controller: myController3,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      color:Colors.cyan,
                      onPressed: myController3.clear,
                      icon: Icon(Icons.restore_from_trash_sharp),
                    ),
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
                ),
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
                  child: buton_getir(),
              ),
              SizedBox(
                width: 30.sp,
              ),
              ElevatedButton(
                onPressed: () {
                  tur(zikirs);
                },
                child: Ikon_getir(is_playing),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(CircleBorder()),
                  padding: MaterialStateProperty.all(EdgeInsets.all(25.sp)),
                  backgroundColor: MaterialStateProperty.all(Colors.cyan), // <-- Button color
                  overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(MaterialState.pressed)) return Colors.cyan.shade700; // <-- Splash color
                  }),
                ),
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
                                  if(zikir!=null){
                                    zikirs.zikirler[zikir] =0;
                                  }else{
                                    zikirs.zikirler["İsimsiz Zikir"] =0;
                                  }
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
          SizedBox(height: 2.h,),
          Container(
            height:50,//50
            width:130,
            child: LiteRollingSwitch(
              value: true,
              textOn: 'SAYAÇ',
              textOff: 'ZAMAN',
              colorOn: Colors.lightBlue,
              colorOff: Colors.blue,
              iconOn: Icons.add_outlined,
              iconOff: Icons.timer_outlined,
              onChanged: (bool state) {    setState(() {
                deger = state;
              });
              print(state);
              print('turned ${(state) ? 'on' : 'off'}');
              },
            ),
          ),
        ],
      ),
    );
  }

  void tur(reporosopty zikirs) {
    if (deger == true) {
      setState(() {
        playbutton(1);
        progressValue = progressValue + 1;
        kaydet(zikirs);
      });
      if (progressValue == 100) {
        playbutton(2);
        sayac = sayac + 1;
        progressValue = 1;
      }

    } else {
      if (is_playing == false) {
        is_playing = true;
        setState(() {});
        print(is_playing);
        print("asd");
        timer = Timer.periodic(
          Duration(microseconds: sure),
              (timer) {
            setState(() {
              //print(sure);
              //print(zikirs.zikir_sureleri);
              playbutton(1);
              progressValue++;
              kaydet(zikirs);
              if (progressValue == 100) {
                playbutton(2);
                sayac = sayac + 1;
                progressValue = 1;
              }
            }
            );
          },
        );
      } else {
        //print(is_playing);
        //print(sure);
        setState(() {
          timer?.cancel();
        });
        is_playing = false;
      }
    }
  }
  void kaydet(reporosopty zikirs) {
    if (myController3.text.isEmpty) {
      zikirs.zikir_ekle("İsimsiz Zikir", progressValue.toInt() + sayac * 99);
    }else{
      zikirs.zikir_ekle(myController3.text, progressValue.toInt() + sayac * 99);
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

    if( deger == true){
      return Icon(Icons.add,size: 20.sp,color: Colors.white,);
    }
    else{
      if (is_playing == false) {
        return Icon(Icons.play_arrow, size: 20.sp, color: Colors.white,);
      }else{
        return Icon(Icons.pause,size: 20.sp,color: Colors.white,);
    }

  }
}

  buton_getir() {
    if(
    deger == false
    ){
      return ElevatedButton(
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
      );
    }
  }

  void playbutton(int soundNumber)  {
    final player = AudioCache();
    if (soundNumber == 1){
      //player.play(AssetSource('note8.wav'));
      player.play('note10.wav');
      //player.play('note8.wav');
    }else{
      //player.play(AssetSource('bing2.mp3'));
      player.play('bing2.mp3');
    }
  }

}
