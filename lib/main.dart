import 'package:dhikrmatic/sayaclar.dart';
import 'package:dhikrmatic/settings.dart';
import 'package:dhikrmatic/butonlu_sayac..dart';
import 'package:dhikrmatic/settings2.dart';
import 'package:dhikrmatic/zaman_ayarlı.dart';
import 'package:dhikrmatic/zikirler_reporository.dart';
import 'package:dhikrmatic/zikirlerr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'ad_helper.dart';

List<String> testDeviceIds = ["9F3F8892CE975CE6F7011D17633461E7"];


void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  RequestConfiguration configuration =
  RequestConfiguration(testDeviceIds: testDeviceIds);
  MobileAds.instance.updateRequestConfiguration(configuration);


  runApp(ProviderScope(child: const MyApp()));
}





class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.zikirismi}) : super(key: key);
  final zikirismi ;

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
       return MaterialApp(
         debugShowCheckedModeBanner: false,
         title: 'Zikirmatik',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: MyHomePage(title: 'Zikirmatik',zikir: zikirismi,),
      );}
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  MyHomePage({Key? key, required this.title,this.zikir}) : super(key: key);


  final String title;

  final zikir;
  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState(zikir);
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  bool deger = true;
  bool status = false;

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;


  var zikir;

  _MyHomePageState(this.zikir);

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  void initState() {
    // TODO: implement initState
    _loadBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final zikirs = ref.watch(zikir_provider);
    return Scaffold(
      appBar: AppBar(
        title:  Text("ZİKİRMATİK",
          style: TextStyle(
              fontFamily: "Pacifico",
              color: Colors.cyan
          ),),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){
            if(zikirs.acil == true){
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Uyarı',
                      style: TextStyle(
                          fontFamily: "Pacifico"),),
                    content: const Text('Zikirler sayfasına gitmek için zamanlayıcıyı durdurmalısınız.',
                      style: TextStyle(fontFamily: "Pacifico",
                          //fontSize: ,
                          color: Colors.white),
                    ),
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))
                    ) ,
                    backgroundColor: Colors.cyan,
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Tamam'),
                        child: const Text('Tamam',
                          style: TextStyle(fontFamily: "Pacifico",
                              color: Colors.white),),
                      ),
                    ],
                  ));
            }else{
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => yeniiPhone13mini1()));
            }
          }, icon: Icon(
            Icons.list_alt,
            color:Colors.cyan,
            size: 35,
          )),
        ],),
      body:
          SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
             child: ConstrainedBox(
            constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                      height: 81.h,
                      width: 100.w,
                      child: sayaclar(zikir: zikir,)),
                  Container(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: _bannerAd.size.width.toDouble(),
                          height: _bannerAd.size.height.toDouble(),
                          child: AdWidget(ad: _bannerAd),
                        ),
                  ),),
                ],
              ),
            ),
          )
    ),
    );
  }
}
