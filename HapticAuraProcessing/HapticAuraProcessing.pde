import de.voidplus.leapmotion.*;
LeapMotion leap;


import controlP5.*;//import controlP5 library

ControlP5 cp5;
// Serial Port Output
import processing.serial.*; // Serial libraries, send OUTPUT through USB
Serial myPort;
int ledPin;
int checkPin;

int Xvalue = color(0,0,0);
int Yvalue = color(0,0,0);
int Zvalue = color(0,0,0);

void setup() {
  size(800, 500, P3D);
  background(255);
  noStroke();
  fill(50);
   cp5 = new ControlP5(this);
  
   cp5.addSlider("XAxisValue") //add a new Button for X axis
     .setPosition(20,300)
     .setSize(100,20)
     .setRange(0,200)
     .setValue(50)
     ;
     
    cp5.addSlider("YAxisValue") //add a new Button for X axis
     .setPosition(20,350)
     .setSize(100,20)
     .setRange(0,200)
     .setValue(50)
     ;
     
     cp5.addSlider("ZAxisValue") //add a new Button for X axis
     .setPosition(20,400)
     .setSize(100,20)
     .setRange(0,120)
     .setValue(50)
     ;
     
       cp5.getController("ZAxisValue").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("ZAxisValue").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  // New port object
  //println(Serial.list());
  myPort = new Serial(this, Serial.list()[3], 9600);
  // New leap object
  leap = new LeapMotion(this);
}

void draw() {
  background(255);
  
  //  fill(80);
  fill(Xvalue);
  rect(0,280,width,70);
  
  fill(Yvalue);
  rect(0,350,width,50);
  
  fill(Zvalue);
  rect(0,400,width,100);
  
  
  // Leap magic
  int fps = leap.getFrameRate();
  // Clean LEAP Hand position

  
  for (Hand hand : leap.getHands()) {
    hand.draw();
    PVector hand_position = hand.getPosition();
    //println("Hand on X: " + hand.getPosition().x );
    
      //PVector finger_position = hand.getFinger(1).getPosition();
      float posZ = hand.getFinger(1).getPosition().z - 48;
      float posX = hand.getFinger(1).getPosition().x - 420;
      float posY = 460 - hand.getFinger(1).getPosition().y;
      println("finger on z: " + posZ);
      println("finger on x: " + posX);
      println("finger on y: " + posY);
     
     
      if(posZ >= cp5.getController("ZAxisValue").getValue()){
        if(posX >= cp5.getController("XAxisValue").getValue()){
          if(posY >= cp5.getController("YAxisValue").getValue()){
          myPort.write('H');
      
          }
        }
  }
      else{
        myPort.write('L');
      }
      
      
  }
}
void XAxisValue(int theColor) {
  Xvalue = color(theColor);
  println("X Axis Value is Changed to "+theColor);

}
void YAxisValue(int theColor) {
  Yvalue = color(theColor);
  println("Y Axis Value is Changed to "+theColor);

}
void ZAxisValue(int theColor) {
  Zvalue = color(theColor);
  println("Z Axis Value is Changed to "+theColor);

}
