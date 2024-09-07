import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
} 

class _HomePageState extends State<HomePage> {
  bool isHoldingIncrease = false;
  bool isHoldingDecrease = false;

  void increaseGoal() async {
    int elapsedTime = 0; 

    while (isHoldingIncrease) {
      setState(() {
        resetToZero();
        setGoal(_goal + 1);
        elapsedTime = 0; 
      });

      await Future.delayed(const Duration(milliseconds: 500));

      elapsedTime += 500;
      if (elapsedTime >= 700) {
        while (isHoldingIncrease) {
          setState(() {
            resetToZero();
            setGoal(_goal + 1);
          });
          
          await Future.delayed(const Duration(milliseconds: 350));
        }
        setState(() {
          elapsedTime = 0; 
        });
      }
    }
  }


  void decreaseGoal() async {
    int elapsedTime = 0; 

    while (isHoldingDecrease) {
      setState(() {
        if(_goal>1){
          resetToZero();
          setGoal(_goal - 1);
          elapsedTime = 0; 
        }
      });

      await Future.delayed(const Duration(milliseconds: 500)); 

      elapsedTime += 500;
      if (elapsedTime >= 700) {
        while (isHoldingDecrease) {
          setState(() {
            if(_goal>1){
              resetToZero();
              setGoal(_goal - 1);
            }
          });

          await Future.delayed(const Duration(milliseconds: 250)); 
        }

        setState(() {
          elapsedTime = 0; 
        });
      }
    }
  }


  resetToZero({bool resetGoal=false}){
    setCount(_counter=0);
    setFreqTime(_freqTime=0);
    resetGoal==true ? setGoal(_goal=1) : null;
  }

  setCount(int value) async{
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setInt('counter', value);
    getCount();
  }

  setFreqTime(int value) async{
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setInt('freqTime', value);
    getCount();
  }

  setGoal(int value) async{
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setInt('goal', value);
    getCount();
  }

  setColor(int value) async{
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setInt('color', value);
    getCount();
  }

  getCount() async{
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
      _counter=prefs.getInt('counter') ?? 0;

      _freqTime=prefs.getInt('freqTime') ?? 0;

      _goal=prefs.getInt('goal') ?? 1;

      colorHex=prefs.getInt('color') ?? 0xff0A5C36;

    });    
  }

  @override
  void initState() {
    getCount();
    super.initState();
  }

  TextDirection textDirection=TextDirection.rtl;
  int radio=0;
  int colorHex=0xff0A5C36;
  int _counter=0;
  int _freqTime=0;
  int _goal=1;
  bool isActiveColor=false;

  @override
  Widget build(BuildContext context) {

    Color mainColor=Color(colorHex);

    return Directionality(
      textDirection: textDirection,

      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            resetToZero(resetGoal: true);
          },
          backgroundColor: mainColor,
          child: Icon(Icons.refresh, color: Colors.white,),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999), 
          ),
        ),
      
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    isActiveColor=!isActiveColor;
                  });   
                },
                child: Icon((isActiveColor ? Icons.color_lens_outlined : Icons.color_lens), color: Colors.white,)),
            ),
          ],
        ),
      
        body: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: mainColor,
              ),
      
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(child: Text("الهدف", style: TextStyle(color: Colors.white, fontSize: 28),),),
      
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      GestureDetector(
                        onTapDown: (details) {
                          setState(() {
                            isHoldingIncrease = true;
                            increaseGoal();
                          });
                        },
                        onTapUp: (details) {
                          setState(() {
                            isHoldingIncrease = false;
                          });
                        },
                        child: Icon(Icons.add_circle, size: 40, color: Colors.white),
                      ),
      
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text("$_goal", style: TextStyle(color: Colors.white, fontSize: 46),),
                      ),

                      GestureDetector(
                        onTapDown: (details) {
                          setState(() {
                            isHoldingDecrease = true;
                            decreaseGoal();
                          });
                        },
                        onTapUp: (details) {
                          setState(() {
                            isHoldingDecrease = false;
                          });
                        },
                        child: Icon(Icons.remove_circle, size: 40, color: Colors.white),
                      ),
                    ],
                  ),
    
                ],
              ),
            ),
      
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
      
                Text("الإستغفار" , style: TextStyle(color: mainColor, fontSize: 22),),
                
                const SizedBox(
                  height: 4,
                ),
      
                Text("$_counter" , style: TextStyle(color: mainColor, fontSize: 22),),
                
                const SizedBox(
                  height: 20,
                ),
      
                
                CircularPercentIndicator(
                  radius: 80.0,
                  lineWidth: 5.0,
                  percent: _counter/_goal,
                  center: GestureDetector(
                    onTap: (){
                      setState(() {
                        if(_counter<_goal){
                          setCount(_counter+1); 
                        }
                        else{
                          setCount(_counter=1);
                          setFreqTime(_freqTime+1);
                        }
                        
                                               
                      });
                    },
                    child: Icon(
                      Icons.touch_app,
                      size: 50.0,
                      color: mainColor,
                    ),
                  ),
                  backgroundColor: mainColor.withOpacity(0.2),
                  progressColor: mainColor,
                ),
                
      
                const SizedBox(
                  height: 20,
                ),
      
                Text("مرات التكرار : $_freqTime" , style: TextStyle(color: mainColor, fontSize: 22),),
                
                const SizedBox(
                  height: 4,
                ),
      
                Text("المجموع : ${_freqTime*_goal + _counter}" , style: TextStyle(color: mainColor, fontSize: 22),),
                
                const SizedBox(
                  height: 20,
                ),
      
              ],
            ),
      
            Spacer(),
      
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                visible: isActiveColor,
                child: Row(
                  children: [

                    Radio(
                      fillColor: WidgetStateColor.resolveWith((State)=>Color(0xff0A5C36)),
                      value: 0xff0A5C36,
                      groupValue: colorHex,
                      onChanged: (val){
                        setState(() {
                          setColor(val!);
                        });
                    }),

                    Radio(
                      fillColor: WidgetStateColor.resolveWith((State)=>Color(0xff14212A)),
                      value: 0xff14212A,
                      groupValue: colorHex,
                      onChanged: (val){
                        setState(() {
                          setColor(val!);
                        });
                    }),

                    Radio(
                      fillColor: WidgetStateColor.resolveWith((State)=>Color(0xffF4AC2C)),
                      value: 0xffF4BC1C,
                      groupValue: colorHex,
                      onChanged: (val){
                        setState(() {
                          setColor(val!);
                        });
                    }),

                    Radio(
                      fillColor: WidgetStateColor.resolveWith((State)=>Color(0xffB1001C)),
                      value: 0xffB1001C,
                      groupValue: colorHex,
                      onChanged: (val){
                        setState(() {
                          setColor(val!);
                        });
                    }),
                      
                    Radio(
                      fillColor: WidgetStateColor.resolveWith((State)=>Color(0xff62249F)),
                      value: 0xff62249F,
                      groupValue: colorHex,
                      onChanged: (val){
                        setState(() {
                          setColor(val!);
                        });
                    }),
                      
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}