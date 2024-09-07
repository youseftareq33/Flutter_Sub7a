class Item{

  // Attributes
  String? _name; 
  int? _goal;
  int? _counter;
  int? _freqTime;
  int? _sum;


  //=====================================================================
  // Constructor
  Item({required String? name, int? goal, int? counter, int? freqTime, int? sum}){ // required mean cannot be null, {}: to use named parameters
    this._name=name;
    this._goal=goal;
    this._counter=counter;
    this._freqTime=freqTime;
    this._sum=sum;
  }


  //=====================================================================
  // getter and setter

  // name
  get getItemName{
    return _name;
  }

  set setItemName(String? name){
    _name=name;
  }

  //-----------------------

  // goal
  get getItemGoal{
    return _goal;
  }

  set setItemGoal(int? goal){
    _goal=goal;
  }

  //-----------------------

  // counter
  get getItemCounter{
    return _counter;
  }

  set setItemCounter(int? counter){
    _counter=counter;
  }

  //-----------------------

  // freqency Time
  get getItemFreqTime{
    return _freqTime;
  }

  set setItemFreqTime(int? freqTime){
    _freqTime=freqTime;
  }

  //-----------------------

  // sum
  get getItemSum{
    return _sum;
  }

  set setItemSum(int? sum){
    _sum=sum;
  }


  //=====================================================================
  // toString
  @override
  String toString() {
    return "Item name: "+"$_name"+", "+"Item goal: "+"$_goal"+", "+"Item counter: "+"$_counter"+", "+"Item freq_time: "+"$_freqTime"+", "+"Item sum: "+"$_sum";
  }


  
  
}