

void setup() {
  //start serial connection
  Serial.begin(9600);
  //configure pin 2 as an input and enable the internal pull-up resistor
  pinMode(2, INPUT_PULLUP);
  pinMode(3, INPUT_PULLUP);
  pinMode(4, INPUT_PULLUP);
  
}

void loop() {
  //read the pushbutton value into a variable
  int s1 = digitalRead(2);
    int s2 = digitalRead(3);
      int s3 = digitalRead(4);
  //print out the value of the pushbutton
  Serial.write(':');
  Serial.write(s1);
  Serial.write(s2);
  Serial.write(s3);
  
}
