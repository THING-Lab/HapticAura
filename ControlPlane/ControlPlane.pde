import de.voidplus.leapmotion.*;
LeapMotion leap;


import controlP5.*;//import controlP5 library

ControlP5 cp5;
// Serial Port Output
import processing.serial.*; // Serial libraries, send OUTPUT through USB
Serial myPort;
int ledPin;
int checkPin;
int check = 0;
Knob Dial;
int count;
int i = 0;
int j = 0;
float color1;
int a = 0;
int b = 0;
int c = 0;
int d = 0;
int e = 0;
int f = 0;
int g = 0;
int h = 0;

DropdownList d1;

float timeDelay = 100;
int lastTime = 0;
int[] array = new int[9];


void setup() {
  size(800, 500);
  smooth();
  background(255);
  noStroke();
  myPort = new Serial(this, Serial.list()[3], 9600);
  myPort.bufferUntil('\n');
  cp5 = new ControlP5(this);
  fill(2);
  cp5.addButton("Press")
     .setValue(1)
     .setPosition(172,332)
     .setSize(38,38)
     ;
     
  cp5.addSlider("Volume")
     .setPosition(500,200)
     .setWidth(200)
     .setRange(0,200)
     .setValue(50)
     ;
  
  cp5.addSlider("speed")
     .setPosition(20,200)
     .setWidth(200)
     .setRange(0,20)
     .setValue(10)
     ;
  Dial = cp5.addKnob("knobValue")
               .setRange(0,360)
               .setValue(0)
               .setPosition(570,310)
               .setRadius(40)
               .setNumberOfTickMarks(9)
               .setTickMarkLength(4)
               .snapToTickMarks(true)
               .setColorForeground(color(255))
               .setColorBackground(color(0, 160, 100))
               .setColorActive(color(255,255,0))
               .setDragDirection(Knob.HORIZONTAL)
               ;
  
  
  
   d1 = cp5.addDropdownList("myList-d1")
          .setPosition(280, 100)
          .setSize(200,200)
          ;
          
  customize(d1);
  
  // New leap object
  leap = new LeapMotion(this);
  
  
  
 
  
  
}

void serialEvent  (Serial myPort) {

color1  =  float (myPort.readStringUntil ( '\n' ) ) ;  // Changing the background color according to received data

} 

void draw() {

  background(143, 239, 134);
 
  stroke(0);
  fill(123,123,213);
  ellipse(190, 350, 200, 200);
  fill(color1);
  ellipse(190, 350, 70, 70);
  if(array[0] ==0){
     fill(0);
  ellipse(190, 270, 20, 20);}
  
 else{
    fill(255);
  ellipse(190, 270, 20, 20);
}


if(array[1] ==0){
     fill(0);
  ellipse(246, 294, 20, 20);}
 else{
    fill(255);
  ellipse(246, 294, 20, 20);
}
 if(array[2] ==0){
     fill(0);
 ellipse(270, 350, 20, 20);
 }
 else{
    fill(255);
 ellipse(270, 350, 20, 20);

}
 if(array[3] ==0){
     fill(0);
  ellipse(246, 406, 20, 20);
 }
 else{
    fill(255);
  ellipse(246, 406, 20, 20);

}

if(array[4] ==0){
     fill(0);
ellipse(190, 430, 20, 20);
 }
 else{
    fill(255);
ellipse(190, 430, 20, 20);

}
if(array[5] ==0){
     fill(0);
ellipse(134, 406, 20, 20);
 }
 else{
    fill(255);
ellipse(134, 406, 20, 20);
}
if(array[6] ==0){
     fill(0);
  ellipse(110, 350, 20, 20);
 }
 else{
    fill(255);
  ellipse(110, 350, 20, 20);
}
 if(array[7] == 0){
     fill(0);
  ellipse(134, 294, 20, 20);
 }
 else{
    fill(255);
  ellipse(134, 294, 20, 20);
} 
if(array[8] == 0){
     fill(0);
  ellipse(190, 300, 20, 20);
 }
 else{
    fill(255);
ellipse(190, 300, 20, 20);
} 

  //println(timeDelay);
  
  
  if(check == 3){
 
  
    if(millis() - lastTime >= timeDelay){
      
  
  println(millis());
  println(i);
  if(j>0){
  array[j-1] = 0;
  }
  j++;
  array[i] =1;  
  i++;
  if( i == 9){
    i = 0;
  }
  if(j == 10){
    j = 1; 
  }

   
  lastTime= millis();
    }
  }
     
  if(check == 1){
    //println(check);
  
  fill(255);
  ellipse(190, 270, 20, 20);
  fill(255);
  ellipse(190, 430, 20, 20);
  fill(0);
  ellipse(110, 350, 20, 20);
  fill(0);
  ellipse(270, 350, 20, 20);
  fill(0);
  ellipse(134, 294, 20, 20);
  fill(0);
  ellipse(246, 294, 20, 20);
  fill(color1);
  ellipse(134, 406, 20, 20);
  fill(color1);
  ellipse(246, 406, 20, 20);
  fill(0);
  ellipse(190, 300, 20, 20);
  }
  //int i = 1;
  //if(i == 1){
  //  fill(255);
  //ellipse(246, 406, 20, 20);}
  // Leap magic
  
  //println(color1);
  
  int fps = leap.getFrameRate();
  // Clean LEAP Hand position
  
 
  
  
 
  fill(123,123,213);
  ellipse(610, 350, 200, 200);
  fill(150);
  ellipse(610, 350, 70, 70);
  fill(0);
  ellipse(610, 270, 20, 20);
   fill(0);
  ellipse(610, 430, 20, 20);
    fill(0);
  ellipse(530, 350, 20, 20);
  fill(0);
  ellipse(690, 350, 20, 20);
  fill(0);
  ellipse(554, 294, 20, 20);
  fill(0);
  ellipse(666, 294, 20, 20);
  fill(0);
  ellipse(554, 406, 20, 20);
  fill(0);
  ellipse(666, 406, 20, 20);
  fill(0);
  ellipse(610, 300, 20, 20);  
  if(count >30){
  fill(255);
  ellipse(610, 270, 20, 20);
  if(count >70){
  fill(255);
    ellipse(666, 294, 20, 20);}
    if(count >110){
  fill(255);
     ellipse(690, 350, 20, 20);}
     if(count >150){
  fill(255);
     ellipse(666, 406, 20, 20);}
     if(count >190){
  fill(255);
    ellipse(610, 430, 20, 20);}
     if(count >230){
  fill(255);
     ellipse(554, 406, 20, 20);}
     if(count >270){
  fill(255);
     ellipse(530, 350, 20, 20);}
     if(count >310){
  fill(255);
     ellipse(554, 294, 20, 20);}
     if(count >350){
  fill(255);
     ellipse(610, 300, 20, 20);}
}
 
 
}   
 void knobValue(int theValue) {
  count = theValue;
  println("a knob event. setting background to "+theValue);
}


void controlEvent(ControlEvent theEvent) {
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.
println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
 
  if(theEvent.getController().getValue()==1.0){

  check = 1;

  }
  if(theEvent.getController().getValue()==3.0){

  check = 3;

  }

  //if (theEvent.isGroup()) {
  //  // check if the Event was triggered from a ControlGroup
  //  println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  //} 
  //else if (theEvent.isController()) {
  //  println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  //}
}


void speed(float cc) {
  
  timeDelay = 1000 - cc * 50;
  
}

void customize(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.getCaptionLabel().set("function");
  ddl.addItem("left to right", 0);
  ddl.addItem("circular counterclock wise", 1);
  ddl.addItem("pulsing", 2);
  ddl.addItem("circular clockwise", 3);
  ddl.addItem("right to left", 4);
  ddl.addItem("bottom to top", 5);
  ddl.addItem("top to bottom", 6);
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
} 
  
  
  
void keyPressed(){
  
  if (key=='0') {
    if((((a+1)/2) -(a/2)) == 0)
     {
      myPort.write("AH");
      a++; 
       println("AH");  
   }
   else{
      myPort.write("AL");
      a++; 
      println("AL");   
   }
} 
if (key=='1') {
    //if((((b+1)/2) -(b/2)) == 0)
     //{
      myPort.write("BH");
      b++; 
       println("BH");    
   //}
   //else{
   //   myPort.write("BL");
   //   b++;
   //    println("BL");  
   //}
} 
if (key=='2') {
    if((((c+1)/2) -(c/2)) == 0)
     {
      myPort.write("CH");
      c++;  
     println("CH");  
   }
   else{
      myPort.write("CL");
      c++; 
       println("CL");
   }
} 
if (key=='3') {
    if((((d+1)/2) -(d/2)) == 0)
     {
      myPort.write("DH");
      d++; 
       println("DH");  
   }
   else{
      myPort.write("DL");
      d++; 
    println("DL");  
   }
} 
if (key=='4') {
    if((((e+1)/2) -(e/2)) == 0)
     {
      myPort.write("EH");
      e++; 
       println("EH");   
   }
   else{
      myPort.write("EL");
      e++; 
       println("EL");   
   }
} 
if (key=='5') {
    if((((f+1)/2) -(f/2)) == 0)
     {
      myPort.write("FH");
      f++; 
       println("FH");  
   }
   else{
      myPort.write("FL");
      f++; 
       println("FL");  
   }
} 
if (key=='6') {
    if((((g+1)/2) -(g/2)) == 0)
     {
      myPort.write("GH");
      g++; 
       println("GH");  
   }
   else{
      myPort.write("GL");
      g++; 
       println("GL");  
   }
} 


if (key=='7') {
    if((((h+1)/2) -(h/2)) == 0)
     {
      myPort.write('A');
      h++; 
      println("A");
   }
   else{
      myPort.write('B');
      h++; 
  println("B");  
 }
} 
  
  
  
}
