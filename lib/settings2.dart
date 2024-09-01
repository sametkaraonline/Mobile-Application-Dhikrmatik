import 'dart:async';

import 'package:dhikrmatic/zikirler_reporository.dart';
import 'package:dhikrmatic/zikirlerr.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';


String formatTime(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}


class StopwatchPage extends ConsumerStatefulWidget {
  const StopwatchPage({Key? key,this.zikir}) : super(key: key);

  final zikir;

  @override
  ConsumerState createState() => _StopwatchPageState(zikir);
}


class _StopwatchPageState extends ConsumerState<StopwatchPage> {
  late Stopwatch _stopwatch;

  final zikir;

  _StopwatchPageState(this.zikir);
  void handleStartStop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }
    setState(() {});    // re-render the page
  }

  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    // re-render every 30ms
    _timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final zikirs = ref.watch(zikir_provider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.cyan,),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title:  Text("KRONOMETRE",
          style: TextStyle(
              fontFamily: "Pacifico",
              color: Colors.cyan
          ),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Zikriniz için sürenizi ölçün.",style: TextStyle(
              fontFamily: "Pacifico",
              color: Colors.cyan,
              fontSize: 30,
            )),
            Text(formatTime(_stopwatch.elapsedMicroseconds), style: TextStyle(
              fontFamily: "Pacifico",
              color: Colors.cyan,
              fontSize: 30,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 82,
                  height: 60,
                  child: ElevatedButton(
                    onPressed:(){
                      print(_stopwatch.elapsedMicroseconds);
                      if (zikir == null){
                        zikirs.zikir_ekle(" ", _stopwatch.elapsedMicroseconds);
                        zikirs.zikir_suresi_ekle(" ", _stopwatch.elapsedMicroseconds);
                        print(zikirs.zikir_sureleri);
                        //setstate yapalım
                        Navigator.pop(context);
                      }else {
                        zikirs.zikir_suresi_ekle(zikir, _stopwatch.elapsedMicroseconds);
                        print(zikirs.zikir_sureleri);
                        Navigator.pop(context);
                      }
                      },

                    child: Text('Kaydet',style: TextStyle(
                    fontFamily: "Pacifico",
                    color: Colors.white,
                    fontSize: 15,
                  )),   style: OutlinedButton.styleFrom(
                    primary: Colors.cyan, // background
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),),
                ),
                SizedBox(
                  width: 40,
                ),
                SizedBox(
                  width: 82,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: handleStartStop, child: Text(_stopwatch.isRunning ? 'Durdur' : 'Başlat',style: TextStyle(
                    fontFamily: "Pacifico",
                    color: Colors.white,
                    fontSize: 15,
                  )),   style: OutlinedButton.styleFrom(
                    primary: Colors.cyan, // background
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}