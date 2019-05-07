import processing.serial.*;

Serial myPort;  // Create object from Serial class
int data[];     // Data received from the serial port
int nbytes;

// receives info from Arduino. 3 Buttons, OFF / ON

void startSerie(){
  
  String portName = Serial.list()[0]; // check for correct port
  myPort = new Serial(this, portName, 9600);
  nbytes = 0;
  data = new int[7];
}

void serie(){
  
  while (myPort.available() > 0) {
    int val = myPort.read();
    if (val == 58) {
      nbytes = 0;
    } else {
      data[nbytes] = val;
      nbytes++;
    }
  }
 
}
