import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherApp extends StatefulWidget {

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String time='',dayName='',date='',monthName='',year='',timeOfDay='';
  String temp='',wind='',humidity='',asset='';
  String? API1=dotenv.env['API_KEY_1'];
  String? API2=dotenv.env['API_KEY_2'];
  String day(int x){
    if(x==1)
      return 'Monday';
    else if(x==2)
      return 'Tuesday';
    else if(x==3)
      return 'Wednesday';
    else if(x==4)
      return 'Thursday';
    else if(x==5)
      return 'Friday';
    else if(x==6)
      return 'Saturday';
    else
      return 'Sunday';
  }
  String month(String mon){
    if(mon=='01')
      return 'January';
    else if(mon=='02')
      return 'February';
    else if(mon=='03')
      return 'March';
    else if(mon=='04')
      return 'April';
    else if(mon=='05')
      return 'May';
    else if(mon=='06')
      return 'June';
    else if(mon=='07')
      return 'July';
    else if(mon=='08')
      return 'August';
    else if(mon=='09')
      return 'September';
    else if(mon=='10')
      return 'October';
    else if(mon=='11')
      return 'November';
    else
      return 'December';
  }
  String windConvert(double x){
    int y=(x*18/5).round();
    return y.toString();
  }
  String dayDivide(int x){
    if(x>=5 && x<12)
      return 'Morning';
    else if(x>=12 && x<17)
      return 'Afternoon';
    else if(x>=17 && x<21)
      return 'Evening';
    else if(x>=0 && x<4)
      return 'Midnight';
    else
      return 'Night';
  }
  void getTime() async{
    Response response= await get(Uri.parse(API1!));
    Map data=jsonDecode(response.body);
    String datetime=data['datetime'];
    int day_name=data['day_of_week'];
    String offset_hr=data['utc_offset'].substring(1,3);
    String offset_min=data['utc_offset'].substring(4);
    DateTime now= DateTime.parse(datetime);
    now=now.add(Duration(hours: int.parse(offset_hr),minutes: int.parse(offset_min)));
    String hr_min=now.toString().substring(11,16);
    String year1=now.toString().substring(0,4);
    String date1=now.toString().substring(8,10);
    String month_name=now.toString().substring(5,7);
  // print(month(month_name));
  // print('$hr_min - ${day(day_name)}, ${month(month_name)} ');
  setState(() {
    time=hr_min;
    dayName=day(day_name);
    date=date1;
    monthName=month(month_name);
    year=year1;
    timeOfDay=dayDivide(int.parse(hr_min.substring(0,2)));
    //asset='assets/$timeOfDay.svg';
  });
  }
  void getWeather() async{
    Response response=await get(Uri.parse(API2!));
    Map data=jsonDecode(response.body);
    String tempData=(data['main']['temp']-273).round().toString();
    double windSpeed=(data['wind']['speed']);
    String hum=(data['main']['humidity']).toString();
    //print(windSpeed);
    setState(() {
      temp=tempData;
      wind=windConvert(windSpeed);
      humidity=hum;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTime();
    getWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){},
          icon: const Icon(
              Icons.search,
              size: 30.0,
              color: Colors.white
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0,0,20.0,0),
            child: GestureDetector(
              onTap: ()=> print('menu clicked'),
              child: SvgPicture.asset(
                  'assets/menu.svg',
                height: 30.0,
                width: 30.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/$timeOfDay.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black38),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 120.0),
                            Text(
                              'Kolkata',
                              style: GoogleFonts.aclonica(
                                fontSize: 34.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              '$time - $dayName, $date $monthName $year',
                              style: GoogleFonts.aclonica(
                                  fontSize: 14.0,
                                  color: Colors.white,
                            ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$temp°C',
                              style: GoogleFonts.aclonica(
                                fontSize: 85.0,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset('assets/$timeOfDay.svg',
                                width: 34,height: 34,color: Colors.white,),
                                SizedBox(width: 10,),
                                Text(
                                  '$timeOfDay',
                                  style: GoogleFonts.aclonica(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 40.0),
                        decoration: BoxDecoration(border: Border.all(
                          color: Colors.white,
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Wind',
                                  style: GoogleFonts.aclonica(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '$wind',
                                  style: GoogleFonts.aclonica(
                                    fontSize: 24.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Km/h',
                                  style: GoogleFonts.aclonica(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 50,
                                      color: Colors.white38,
                                    ),
                                    Container(
                                      height: 5,
                                      width: 5,
                                      color: Colors.greenAccent,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Humidity',
                                  style: GoogleFonts.aclonica(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '$humidity',
                                  style: GoogleFonts.aclonica(
                                    fontSize: 24.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '%',
                                  style: GoogleFonts.aclonica(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 50,
                                      color: Colors.white38,
                                    ),
                                    Container(
                                      height: 5,
                                      width: 5,
                                      color: Colors.redAccent,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
