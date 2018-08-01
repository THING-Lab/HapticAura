//// Mechamagnets instrumentation and visualization via linear hall effect sensors
//// Clement Zheng 2018

// Visualize and calibrate Mechamagnet objects with this sketch.
// Each object's calibration is saved to a CSV file in this sketch's data folder, named with its "name" variable.


boolean fileLoaded = false;

color blue = #335755;
color white = #EDDDBB;
color grey = #3D3B38;
color black = #0C0A0B;

PFont Arial;
PImage bckgrd;

float  songProgress;
float  volume = 0.5;
float volumeSliderX;

int playButtonAlpha = 150;
int loadFileAlpha = 150;
int progressBarAlpha = 150; // bar
int soundVisionAlpha = 50;  // visual;

String state = "PLAY";
String title = "";

import ddf.minim.*;
import ddf.minim.analysis.*;

AudioMetaData meta;
Minim minim;
AudioPlayer player;
FFT fft;



PImage fai_iconi;
PGraphics fai_icong;
String fai_filename;

import processing.serial.*;

//ARDUINO Serial data format:
//separate each hall effect reading with a space (" ")
//use a new line to send each frame of data
//PROCESSING will split each line using the space delimiter to create an array of readings for each frame
Serial myPort;
int SERIAL_PORT_INDEX = 3; //Check arduino "port" menu and count from the top to the serial port, start from 0.
int SERIAL_ARRAY_SIZE = 0; //Incremented automatically when a new mechamagnet object is created.
float[] SERIAL_DATA = {0, 0};
 
MMButton button1, button2;
MMKnob knob1;
MMStick stick1;


import de.voidplus.leapmotion.*;
LeapMotion leap;


import controlP5.*;//import controlP5 library

ControlP5 cp5;
// Serial Port Output
import processing.serial.*; // Serial libraries, send OUTPUT through USB

int ledPin;
int checkPin;
int check1 = 0;
int check2 = 0;
int check3 = 1;
int check4 = 1;
Knob Dial;
int count;
int i = 1;
int j = 1;
int k = 8;
int l = 8;
int i2 = 1;
int j2 = 1;
int k2 = 8;
int l2 = 8;


float color1;
int a = 0;
int b = 0;
int c = 0;
int d = 0;
int e = 0;
int f = 0;
int g = 0;
int h = 0;
int LRCount1 = 0;
int RLCount1 = 0;
int BTCount1 = 0;
int TBCount1 = 0;
int PulseCount1 = 0;
int LRCount2 = 0;
int RLCount2 = 0;
int BTCount2 = 0;
int TBCount2 = 0;
int PulseCount2 = 0;
int LeftCount = 0;
int RightCount = 0;
DropdownList d1;
DropdownList d2;
DropdownList d3;
DropdownList d4;

float timedelay1 = 100;
float timedelay2 = 100;
float timedelay3 = 100;
float timedelay4 = 100;
int lastTime1 = 0;
int lastTime2 = 0;
int lastTime3 = 0;
int lastTime4 = 0;
int[] leftarray = new int[10];
int[] rightarray = new int[10];


void setup() {
  size(800, 500);
  smooth();
  Arial = loadFont("data/Arial.vlw");
  background(255);
  noStroke();

  myPort = new Serial(this, Serial.list()[4], 9600);
  button1 = new MMButton("BUTTON 1", 0, false, 0.5, 50, 50, 80, 200); //arguments: name, serial data index, inverted?, trigger threshold (0-1), xpos, ypos, width, height
  button2 = new MMButton("BUTTON 2", 1, false, 0.5, 150, 50, 80, 200);
  knob1 = new MMKnob("KNOB 1", 1, 2, false, 300, 50, 150); //arguments: name, serial data index A, serial data index B, inverted?, xpos, ypos, diameter
  stick1 = new MMStick("STICK 1", 1, 0, false, true, 500, 50, 150); //arguments: name, serial data index A, serial data index B, inverted x?, inverted y?, xpos, ypos, diameter
  //note: if the inverse variable does not work for knobs or sticks, try swapping the serial data indices instead.
  volumeSliderX = width-30;

  minim = new Minim(this);

  myPort.bufferUntil('\n');
  cp5 = new ControlP5(this);
  fill(2);
  cp5.addButton("Press") //add the press button
    .setValue(1)
    .setPosition(172, 332) 
    .setSize(38, 38)
    ;



  cp5.addSlider("speed1") //add the speed slider for the left valves  
    .setPosition(100, 200)
    .setWidth(200)
    .setRange(0, 20)
    .setValue(10)
    ;

  cp5.addSlider("Speed1forCenter") //add the speed slider for the left center valve to pulse
    .setPosition(100, 220)
    .setWidth(200)
    .setRange(0, 20)
    .setValue(10)
    ;  


  cp5.addSlider("speed2") //add the speed slider for the right valves
    .setPosition(500, 200)
    .setWidth(200)
    .setRange(0, 20)
    .setValue(10)
    ;

  cp5.addSlider("Speed2forCenter")//add the speed slider for the right center valve to pulse
    .setPosition(500, 220)
    .setWidth(200)
    .setRange(0, 20)
    .setValue(10)
    ;  
  Dial = cp5.addKnob("knobValue") //add the knob for adjusting 
    .setRange(0, 360)
    .setValue(0)
    .setPosition(570, 310)
    .setRadius(40)
    .setNumberOfTickMarks(9)
    .setTickMarkLength(4)
    .snapToTickMarks(true)
    .setColorForeground(color(255))
    .setColorBackground(color(0, 160, 100))
    .setColorActive(color(255, 255, 0))
    .setDragDirection(Knob.HORIZONTAL)
    ;



  d1 = cp5.addDropdownList("LeftList") // add the droplist for left valves animation 
    .setPosition(100, 10)
    .setSize(200, 180)
    ;

  customize1(d1);

  d2 = cp5.addDropdownList("RightList")// add the droplist for right valves animation
    .setPosition(500, 10)
    .setSize(150, 180)
    ;

  customize1(d2);

  d3 = cp5.addDropdownList("LeftCenter")// add the droplist for left center animation
    .setPosition(320, 10)
    .setSize(70, 150)
    ;

  customize2(d3);

  d4 = cp5.addDropdownList("RightCenter")// add the droplist for right center animation
    .setPosition(420, 10)
    .setSize(70, 150)
    ;

  customize2(d4);

  // New leap object
  leap = new LeapMotion(this);
}




void draw() {
  background(white);
  smooth(28);
  readSerial(); //listens to the serial port defined in setup, and updates SERIAL_DATA array

  button1.update(SERIAL_DATA); //updates object with new serial data.
  button2.update(SERIAL_DATA);
  knob1.update(SERIAL_DATA);
  stick1.update(SERIAL_DATA);
  //button1.display(); //display the object's visualization and calibration GUI.
  //button2.display();
  //knob1.display();
  //stick1.display();


  //if (knob1.angle > 4.4)
  //    knob1.angle = - 1.8;

  //volume = (knob1.angle-1.6) * 15;
println(volume);






  if (fileLoaded) {
    soundVision();                  //Calls visualizer function
    player.setGain(volume);

    fill(0, 0, 0, 255);
    textSize(21);    //Prints title out
    textAlign(CENTER);
    text(title, width/2, 30);
  }
  buttons();    //execute button function 
  //println(knob1.angle);
  //background(143, 239, 134);

  //mouseReleased();
  stroke(0);
  fill(123, 123, 213);
  ellipse(190, 350, 200, 200);
  fill(0);
  ellipse(190, 350, 70, 70); //check if the array of valve value is 1 or 0 to turn valve on and off
  if (leftarray[1] ==0) {
    fill(0);
    ellipse(190, 270, 20, 20);
    myPort.write(1);
  } else {
    fill(255);
    ellipse(190, 270, 20, 20);
    myPort.write(2);
  }


  if (leftarray[2] ==0) {
    fill(0);
    ellipse(246, 294, 20, 20);
    myPort.write(3);
  } else {
    fill(255);
    ellipse(246, 294, 20, 20);
    myPort.write(4);
  }
  if (leftarray[3] ==0) {
    fill(0);
    ellipse(270, 350, 20, 20);
    myPort.write(5);
  } else {
    fill(255);
    ellipse(270, 350, 20, 20);
    myPort.write(6);
  }
  if (leftarray[4] ==0) {
    fill(0);
    ellipse(246, 406, 20, 20);
    myPort.write(7);
  } else {
    fill(255);
    ellipse(246, 406, 20, 20);
    myPort.write(8);
  }

  if (leftarray[5] ==0) {
    fill(0);
    ellipse(190, 430, 20, 20);
    myPort.write(9);
  } else {
    fill(255);
    ellipse(190, 430, 20, 20);
    myPort.write(10);
  }
  if (leftarray[6] ==0) {
    fill(0);
    ellipse(134, 406, 20, 20);
    myPort.write(11);
  } else {
    fill(255);
    ellipse(134, 406, 20, 20);
    myPort.write(12);
  }
  if (leftarray[7] ==0) {
    fill(0);
    ellipse(110, 350, 20, 20);
    myPort.write(13);
  } else {
    fill(255);
    ellipse(110, 350, 20, 20);
    myPort.write(14);
  }
  if (leftarray[8] == 0) {
    fill(0);
    ellipse(134, 294, 20, 20);
    myPort.write(15);
  } else {
    fill(255);
    ellipse(134, 294, 20, 20);
    myPort.write(16);
  } 
  if (leftarray[9] == 0) {
    fill(0);
    ellipse(190, 300, 20, 20);
    myPort.write(33);
  } else {
    fill(255);
    ellipse(190, 300, 20, 20);
    myPort.write(34);
  } 

  //println(timedelay1);
  if (check3 == 0) {


    leftarray[9] = 1;
  }
  if (check3 == 1) {


    leftarray[9] = 0;
  }
  if (check3 == 2) {



    if (millis() - lastTime3 >= timedelay3) {




      if ( LeftCount == 0)
      {

        leftarray[9] = 1;
        LeftCount++;
      } else  if ( LeftCount == 1) {

        leftarray[9] = 0;
        LeftCount = 0;
      }

      lastTime3= millis();
    }
  }



 
  if (check1 == 0) {  // if check1 = 0 , all the left valves will be static 

    for (int v = 1; v < 9; v++)
      leftarray[v] = 0;
  }
  if (check1 == 1) { // if check1 = 1, it will do clockwise animation


    if (millis() - lastTime1 >= timedelay1) {


      //println(millis());
      if (j>1) {
        leftarray[j-1] = 0;
        //myPort.write(2*j-3);
        // println(2*j-3);
      }
      j++;
      leftarray[i] =1; 
      //myPort.write(2*i);
      //  println(2*i);
      i++;

      if ( i == 9) {
        i = 1;
      }

      if (j == 10) {
        j = 2;
      }


      lastTime1= millis();
    }
  }


  if (check1 == 2) { // if check1 = 2, it will do counterclockwise animation



    if (millis() - lastTime1 >= timedelay1) {


      //println(millis());
      if (l<8) {
        leftarray[l+1] = 0;
        //myPort.write(2*l+1);
        //  println(2*l+1);
      }
      l--;
      leftarray[k] =1; 
      //myPort.write(2*k);
      //  println(2*k);
      k--;

      if ( k == 0) {
        k = 8;
      }

      if (l == -1) {
        l = 7;
      }


      lastTime1= millis();
    }
  }  


  if (check1 == 3) {// if check1 = 3, it will do pulsing animation



    if (millis() - lastTime1 >= timedelay1) {




      if ( PulseCount1 == 0)
      {
        for (int b = 1; b < 5; b++ ) {

          leftarray[2*b] = 1; 
          //    myPort.write(4*b);
        }
        PulseCount1++;
      } else  if ( PulseCount1 == 1) {

        for (int b = 1; b < 5; b++ ) {

          leftarray[2*b] = 0; 
          //  myPort.write(4*b-1);
        }
        PulseCount1++;
      } else  if ( PulseCount1 == 2) {
        for (int b = 1; b < 5; b++ ) {
          leftarray[2*b-1] = 1; 
          //myPort.write(4*b-2);
        }
        PulseCount1++;
      } else  if ( PulseCount1 == 3) {
        for (int b = 1; b < 5; b++ ) {
          leftarray[2*b-1] = 0; 
          //myPort.write(4*b-3);
        }
        PulseCount1 = 0;
      }
      lastTime1= millis();
    }
  }
  if (check1 == 4) {// if check1 = 4, it will do left to right animation


    if (millis() - lastTime1 >= timedelay1) {

      if ( LRCount1 == 0) {
        leftarray[3] = 0;
        //myPort.write(5);
        leftarray[7] = 1; 
        //myPort.write(14);
        LRCount1++;
      } else if ( LRCount1 == 1) {
        leftarray[7] = 0;
        //myPort.write(13);
        leftarray[6] = 1;
        //myPort.write(12);
        leftarray[8] = 1;
        //myPort.write(16);
        LRCount1++;
      } else if ( LRCount1 == 2) {
        leftarray[6] = 0;
        //myPort.write(11);
        leftarray[8] = 0;
        //myPort.write(15);
        leftarray[1] = 1;
        //myPort.write(2);
        leftarray[5] = 1;
        //myPort.write(10);
        LRCount1++;
      } else if ( LRCount1 == 3) {
        leftarray[1] = 0;
        //myPort.write(1);
        leftarray[5] = 0;
        //myPort.write(9);
        leftarray[2] = 1;
        //myPort.write(4);
        leftarray[4] = 1;
        //myPort.write(8);
        LRCount1++;
      } else if ( LRCount1 == 4) {
        leftarray[2] = 0;
        // myPort.write(3);
        leftarray[4] = 0;
        //myPort.write(7);
        leftarray[3] = 1;
        //myPort.write(6);
        LRCount1 = 0;
      }





      lastTime1= millis();
    }
  }  
  if (check1 == 5) {// if check1 = 5, it will do right to left animation


    if (millis() - lastTime1 >= timedelay1) {

      if ( RLCount1 == 0) {
        leftarray[3] = 1;
        //myPort.write(6);
        leftarray[7] = 0;
        //myPort.write(13);
        RLCount1++;
      } else if ( RLCount1 == 4) {
        leftarray[7] = 1;
        //myPort.write(14);
        leftarray[6] = 0;
        //myPort.write(11);
        leftarray[8] = 0;
        //myPort.write(15);
        RLCount1 = 0;
      } else if ( RLCount1 == 3) {
        leftarray[6] = 1;
        //myPort.write(12);
        leftarray[8] = 1;
        //myPort.write(16);
        leftarray[1] = 0;
        //myPort.write(1);
        leftarray[5] = 0;
        //myPort.write(9);
        RLCount1++;
      } else if ( RLCount1 == 2) {
        leftarray[1] = 1;
        //myPort.write(2);
        leftarray[5] = 1;
        //myPort.write(10);
        leftarray[2] = 0;
        //myPort.write(3);
        leftarray[4] = 0;
        //myPort.write(7);
        RLCount1++;
      } else if ( RLCount1 == 1) {
        leftarray[2] = 1;
        //myPort.write(2);
        leftarray[4] = 1;
        //myPort.write(8);
        leftarray[3] = 0;
        //myPort.write(5);
        RLCount1++;
      }





      lastTime1= millis();
    }
  }  
  if (check1 == 6) {// if check1 = 6, it will do bottom to top animation


    if (millis() - lastTime1 >= timedelay1) {

      if ( BTCount1 == 0) {
        leftarray[1] = 0;
        //myPort.write(1);
        leftarray[5] = 1;
        //myPort.write(10);
        BTCount1++;
      } else if ( BTCount1 == 1) {
        leftarray[5] = 0;
        //myPort.write(9);
        leftarray[4] = 1;
        //myPort.write(8);
        leftarray[6] = 1;
        //myPort.write(12);
        BTCount1++;
      } else if ( BTCount1 == 2) {
        leftarray[4] = 0;
        //myPort.write(7);
        leftarray[6] = 0;
        //myPort.write(11);
        leftarray[3] = 1;
        //myPort.write(6);
        leftarray[7] = 1;
        //myPort.write(14);
        BTCount1++;
      } else if ( BTCount1 == 3) {
        leftarray[3] = 0;
        //myPort.write(5);
        leftarray[7] = 0;
        //myPort.write(13);
        leftarray[2] = 1;
        //myPort.write(2);
        leftarray[8] = 1;
        //myPort.write(16);
        BTCount1++;
      } else if ( BTCount1 == 4) {
        leftarray[2] = 0;
        //myPort.write(3);
        leftarray[8] = 0;
        //myPort.write(15);
        leftarray[1] = 1;
        //myPort.write(2);
        BTCount1 = 0;
      }





      lastTime1= millis();
    }
  } 


  if (check1 == 7)// if check1 = 7, it will do top to bottom animation
  {


    if (millis() - lastTime1 >= timedelay1) {

      if ( TBCount1 == 0) {
        leftarray[1] = 1;
        // myPort.write(2);
        leftarray[5] = 0;
        //myPort.write(9);
        TBCount1++;
      } else if ( TBCount1 == 4) {
        leftarray[5] = 1;
        //myPort.write(10);
        leftarray[4] = 0;
        //myPort.write(7);
        leftarray[6] = 0;
        //myPort.write(11);
        TBCount1 = 0;
      } else if ( TBCount1 == 3) {
        leftarray[4] = 1;
        //myPort.write(8);
        leftarray[6] = 1;
        //myPort.write(12);
        leftarray[3] = 0;
        //myPort.write(5);
        leftarray[7] = 0;
        //myPort.write(13);
        TBCount1++;
      } else if ( TBCount1 == 2) {
        leftarray[3] = 1;
        //myPort.write(6);
        leftarray[7] = 1;
        //myPort.write(14);
        leftarray[2] = 0;
        //myPort.write(3);
        leftarray[8] = 0;
        //myPort.write(15);
        TBCount1++;
      } else if ( TBCount1 == 1) {
        leftarray[2] = 1;
        //myPort.write(4);
        leftarray[8] = 1;
        //myPort.write(16);
        leftarray[1] = 0;
        //myPort.write(1);
        TBCount1 ++;
      }





      lastTime1= millis();
    }
  }





  int fps = leap.getFrameRate();
  
  
                //leap motion part wait to be finished
  
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
     
     
      if(posZ >= 0){
        if(posX >= 0){
          if(posY >= 0){
         //if (mouseX>0 && mouseX<80 && mouseY < 40) {
    if (state == "PLAY" && fileLoaded) {                              
      state = "PAUSE";                                  //Plays song.
      player.play();
      player.setVolume(volume); //~~~~~~~~~~~~~~~~~~Volume?------------------\\
      //for (int v = 1; v < 9; v++)
      //leftarray[v] = 1;
    } 
    
  }
          }
        }
  
      else{
    if (state == "PAUSE") {
      state = "PLAY";                                  //Pauses song.
      player.pause();
    }
      }
      
      
  }

  
  
  
  
  
  // Clean LEAP Hand position





  fill(123, 123, 213);
  ellipse(610, 350, 200, 200);
  fill(150);
  ellipse(610, 350, 70, 70);
  fill(0);
 
  if (rightarray[1] ==0) {  //check the status of array of right valves to turn on and off
    fill(0);
    ellipse(610, 270, 20, 20);
    myPort.write(17);
  } else {
    fill(255);
    ellipse(610, 270, 20, 20);
    myPort.write(18);
  }


  if (rightarray[2] ==0) {
    fill(0);
    ellipse(666, 294, 20, 20);
    myPort.write(19);
  } else {
    fill(255);
    ellipse(666, 294, 20, 20);
    myPort.write(20);
  }
  if (rightarray[3] ==0) {
    fill(0);
    ellipse(690, 350, 20, 20);
    myPort.write(21);
  } else {
    fill(255);
    ellipse(690, 350, 20, 20);
    myPort.write(22);
  }
  if (rightarray[4] ==0) {
    fill(0);
    ellipse(666, 406, 20, 20);
    myPort.write(23);
  } else {
    fill(255);
    ellipse(666, 406, 20, 20);
    myPort.write(24);
  }

  if (rightarray[5] ==0) {
    fill(0);
    ellipse(610, 430, 20, 20);
    myPort.write(25);
  } else {
    fill(255);
    ellipse(610, 430, 20, 20);
    myPort.write(26);
  }
  if (rightarray[6] ==0) {
    fill(0);
    ellipse(554, 406, 20, 20);
    myPort.write(27);
  } else {
    fill(255);
    ellipse(554, 406, 20, 20);
    myPort.write(28);
  }
  if (rightarray[7] ==0) {
    fill(0);
    ellipse(530, 350, 20, 20);
    myPort.write(29);
  } else {
    fill(255);
    ellipse(530, 350, 20, 20);
    myPort.write(30);
  }
  if (rightarray[8] == 0) {
    fill(0);
    ellipse(554, 294, 20, 20);
    myPort.write(31);
  } else {
    fill(255);
    ellipse(554, 294, 20, 20);
    myPort.write(32);
  } 
  if (rightarray[9] == 0) {
    fill(0);
    ellipse(610, 300, 20, 20);
    myPort.write(35);
  } else {
    fill(255);
    ellipse(610, 300, 20, 20);
    myPort.write(36);
  } 




  if (check4 == 0) {  


    rightarray[9] = 1;
  }
  if (check4 == 1) {


    rightarray[9] = 0;
  }
  if (check4 == 2) {



    if (millis() - lastTime4 >= timedelay4) {


      if ( RightCount == 0)
      {

        rightarray[9] = 1;
        RightCount++;
      } else  if ( RightCount == 1) {

        rightarray[9] = 0;
        RightCount = 0;
      }

      lastTime4= millis();
    }
  }


  if (check2 == 0) {  //if check2 is 0, All right valves will be static

    for (int v = 1; v < 9; v++)
      rightarray[v] = 0;
  }
  if (check2 == 1) { // if check2 is 1, All right valves will do clockwise animation


    if (millis() - lastTime2 >= timedelay2) {


      //println(millis());
      if (j2>1) {
        rightarray[j2-1] = 0;
        //myPort.write(2*j2-3);
        // println(2*j-3);
      }
      j2++;
      rightarray[i2] =1; 
      //myPort.write(2*i2);
      //  println(2*i);
      i2++;

      if ( i2 == 9) {
        i2 = 1;
      }

      if (j2 == 10) {
        j2 = 2;
      }


      lastTime2= millis();
    }
  }


  if (check2 == 2) {  // if check2 is 2, All right valves will do counterclockwise animation


    if (millis() - lastTime2 >= timedelay2) {


      //println(millis());
      if (l2<8) {
        rightarray[l2+1] = 0;
        // myPort.write(2*l2+1);
        //  println(2*l+1);
      }
      l2--;
      rightarray[k2] =1; 
      //myPort.write(2*k2);
      //  println(2*k);
      k2--;

      if ( k2 == 0) {
        k2 = 8;
      }

      if (l2 == -1) {
        l2 = 7;
      }


      lastTime2= millis();
    }
  }  


  if (check2 == 3) {  // if check2 is 3, All right valves will do pulsing animation


    if (millis() - lastTime2 >= timedelay2) {




      if ( PulseCount2 == 0)
      {
        for (int b = 1; b < 5; b++ ) {

          rightarray[2*b] = 1; 
          //    myPort.write(4*b);
        }
        PulseCount2++;
      } else  if ( PulseCount2 == 1) {

        for (int b = 1; b < 5; b++ ) {

          rightarray[2*b] = 0; 
          //myPort.write(4*b-1);
        }
        PulseCount2++;
      } else  if ( PulseCount2 == 2) {
        for (int b = 1; b < 5; b++ ) {
          rightarray[2*b-1] = 1; 
          //myPort.write(4*b-2);
        }
        PulseCount2++;
      } else  if ( PulseCount2 == 3) {
        for (int b = 1; b < 5; b++ ) {
          rightarray[2*b-1] = 0; 
          //       myPort.write(4*b-3);
        }
        PulseCount2 = 0;
      }
      lastTime2= millis();
    }
  }
  if (check2 == 4) {// if check2 is 4, All right valves will do left to right animation


    if (millis() - lastTime2 >= timedelay2) {

      if ( LRCount2 == 0) {
        rightarray[3] = 0;
        //    myPort.write(5);
        rightarray[7] = 1; 
        //   myPort.write(14);
        LRCount2++;
      } else if ( LRCount2 == 1) {
        rightarray[7] = 0;
        //      myPort.write(13);
        rightarray[6] = 1;
        //     myPort.write(12);
        rightarray[8] = 1;
        //     myPort.write(16);
        LRCount2++;
      } else if ( LRCount2 == 2) {
        rightarray[6] = 0;
        //    myPort.write(11);
        rightarray[8] = 0;
        //    myPort.write(15);
        rightarray[1] = 1;
        //    myPort.write(2);
        rightarray[5] = 1;
        //    myPort.write(10);
        LRCount2++;
      } else if ( LRCount2 == 3) {
        rightarray[1] = 0;
        //      myPort.write(1);
        rightarray[5] = 0;
        //      myPort.write(9);
        rightarray[2] = 1;
        //      myPort.write(4);
        rightarray[4] = 1;
        //      myPort.write(8);
        LRCount2++;
      } else if ( LRCount2 == 4) {
        rightarray[2] = 0;
        //   myPort.write(3);
        rightarray[4] = 0;
        //   myPort.write(7);
        rightarray[3] = 1;
        //   myPort.write(6);
        LRCount2 = 0;
      }





      lastTime2= millis();
    }
  }  
  if (check2 == 5) {// if check2 is 5, All right valves will do right to left animation


    if (millis() - lastTime2 >= timedelay2) {

      if ( RLCount2 == 0) {
        rightarray[3] = 1;
        //     myPort.write(6);
        rightarray[7] = 0;
        //     myPort.write(13);
        RLCount2++;
      } else if ( RLCount2 == 4) {
        rightarray[7] = 1;
        //  myPort.write(14);
        rightarray[6] = 0;
        //    myPort.write(11);
        rightarray[8] = 0;
        //    myPort.write(15);
        RLCount2 = 0;
      } else if ( RLCount2 == 3) {
        rightarray[6] = 1;
        //     myPort.write(12);
        rightarray[8] = 1;
        //    myPort.write(16);
        rightarray[1] = 0;
        //    myPort.write(1);
        rightarray[5] = 0;
        //    myPort.write(9);
        RLCount2++;
      } else if ( RLCount2 == 2) {
        rightarray[1] = 1;
        //      myPort.write(2);
        rightarray[5] = 1;
        //      myPort.write(10);
        rightarray[2] = 0;
        //      myPort.write(3);
        rightarray[4] = 0;
        //      myPort.write(7);
        RLCount2++;
      } else if ( RLCount2 == 1) {
        rightarray[2] = 1;
        //      myPort.write(2);
        rightarray[4] = 1;
        //     myPort.write(8);
        rightarray[3] = 0;
        //    myPort.write(5);
        RLCount2++;
      }





      lastTime2= millis();
    }
  }  
  if (check2 == 6) {// if check2 is 6, All right valves will do bottom to top animation


    if (millis() - lastTime2 >= timedelay2) {

      if ( BTCount2 == 0) {
        rightarray[1] = 0;
        //    myPort.write(1);
        rightarray[5] = 1;
        //   myPort.write(10);
        BTCount2++;
      } else if ( BTCount2 == 1) {
        rightarray[5] = 0;
        //   myPort.write(9);
        rightarray[4] = 1;
        //  myPort.write(8);
        rightarray[6] = 1;
        //  myPort.write(12);
        BTCount2++;
      } else if ( BTCount2 == 2) {
        rightarray[4] = 0;
        //  myPort.write(7);
        rightarray[6] = 0;
        //  myPort.write(11);
        rightarray[3] = 1;
        //  myPort.write(6);
        rightarray[7] = 1;
        // myPort.write(14);
        BTCount2++;
      } else if ( BTCount2 == 3) {
        rightarray[3] = 0;
        // myPort.write(5);
        rightarray[7] = 0;
        // myPort.write(13);
        rightarray[2] = 1;
        // myPort.write(2);
        rightarray[8] = 1;
        // myPort.write(16);
        BTCount2++;
      } else if ( BTCount2 == 4) {
        rightarray[2] = 0;
        // myPort.write(3);
        rightarray[8] = 0;
        // myPort.write(15);
        rightarray[1] = 1;
        // myPort.write(2);
        BTCount2 = 0;
      }





      lastTime2= millis();
    }
  } 


  if (check2 == 7)
  {  // if check2 is 7, All right valves will do top to bottom animation


    if (millis() - lastTime2 >= timedelay2) {

      if ( TBCount2 == 0) {
        rightarray[1] = 1;
        //myPort.write(2);
        rightarray[5] = 0;
        //myPort.write(9);
        TBCount2++;
      } else if ( TBCount2 == 4) {
        rightarray[5] = 1;
        // myPort.write(10);
        rightarray[4] = 0;
        //myPort.write(7);
        rightarray[6] = 0;
        //myPort.write(11);
        TBCount2 = 0;
      } else if ( TBCount2 == 3) {
        rightarray[4] = 1;
        //myPort.write(8);
        rightarray[6] = 1;
        //myPort.write(12);
        rightarray[3] = 0;
        //myPort.write(5);
        rightarray[7] = 0;
        //myPort.write(13);
        TBCount2++;
      } else if ( TBCount2 == 2) {
        rightarray[3] = 1;
        //    myPort.write(6);
        rightarray[7] = 1;
        //    myPort.write(14);
        rightarray[2] = 0;
        //    myPort.write(3);
        rightarray[8] = 0;
        //    myPort.write(15);
        TBCount2++;
      } else if ( TBCount2 == 1) {
        rightarray[2] = 1;
        //      myPort.write(4);
        rightarray[8] = 1;
        //     myPort.write(16);
        rightarray[1] = 0;
        //     myPort.write(1);
        TBCount2 ++;
      }





      lastTime2= millis();
    }
  }

  //ellipse(610, 270, 20, 20);
  // fill(0);
  //ellipse(610, 430, 20, 20);
  //  fill(0);
  //ellipse(530, 350, 20, 20);
  //fill(0);
  //ellipse(690, 350, 20, 20);
  //fill(0);
  //ellipse(554, 294, 20, 20);
  //fill(0);
  //ellipse(666, 294, 20, 20);
  //fill(0);
  //ellipse(554, 406, 20, 20);
  //fill(0);
  //ellipse(666, 406, 20, 20);
  //fill(0);
  //ellipse(610, 300, 20, 20);  

  //if (knob1.angle > -0.5) {
  //  fill(255);
  //  ellipse(610, 270, 20, 20);
  //}


  if (count >30) {
    fill(255);
    ellipse(610, 270, 20, 20);
    if (count >70) {
      fill(255);
      ellipse(666, 294, 20, 20);
    }
    if (count >110) {
      fill(255);
      ellipse(690, 350, 20, 20);
    }
    if (count >150) {
      fill(255);
      ellipse(666, 406, 20, 20);
    }
    if (count >190) {
      fill(255);
      ellipse(610, 430, 20, 20);
    }
    if (count >230) {
      fill(255);
      ellipse(554, 406, 20, 20);
    }
    if (count >270) {
      fill(255);
      ellipse(530, 350, 20, 20);
    }
    if (count >310) {
      fill(255);
      ellipse(554, 294, 20, 20);
    }
    if (count >350) {
      fill(255);
      ellipse(610, 300, 20, 20);
    }
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
  println("event from controller : "+theEvent.getController().getName() +" from "+theEvent.getController());
  println(theEvent.getController());

  if ( theEvent.getController().getName() == "LeftCenter") {
    if (theEvent.getController().getValue()==0.0 ) {

      check3 = 0;
    }
    if (theEvent.getController().getValue()==1.0 ) {


      check3 = 1;
    }
    if (theEvent.getController().getValue()==2.0 ) {

      check3 = 2;
    }
  } 

  if ( theEvent.getController().getName() == "RightCenter") {
    if (theEvent.getController().getValue()==0.0 ) {

      check4 = 0;
    }
    if (theEvent.getController().getValue()==1.0 ) {

      check4 = 1;
    }
    if (theEvent.getController().getValue()==2.0 ) {


      check4 = 2;
    }
  } 

  if ( theEvent.getController().getName() == "LeftList") {
    //check = (int)theEvent.getController().getValue();
    if (theEvent.getController().getValue()==0.0 ) {

      check1 = 0;

      i = 1;
      j = 1;
      k = 8;
      l = 8;
      for (int v = 1; v < 10; v++)
        leftarray[v] = 0;
    }

    if (theEvent.getController().getValue()==1.0) {

      check1 = 1;
      for (int v = 1; v < 10; v++)
        leftarray[v] = 0;
      i = 1;
      j = 1;
      k = 8;
      l = 8;
    }
    if (theEvent.getController().getValue()==2.0) { //get value from droplist make the check1 to 2 and all other count to be 1
      for (int v = 1; v < 10; v++)
        leftarray[v] = 0;
      i = 1;
      j = 1;
      k = 8;
      l = 8;

      check1 = 2;
    }
    if (theEvent.getController().getValue()==3.0) {
      for (int v = 1; v < 10; v++)
        leftarray[v] = 0;
      i = 1;
      j = 1;
      k = 8;
      l = 8;

      check1 = 3;
    }  
    if (theEvent.getController().getValue()==4.0) {
      for (int v = 1; v < 10; v++)

        leftarray[v] = 0;
      i = 1;
      j = 1;
      k = 8;
      l = 8;

      check1 = 4;
    }

    if (theEvent.getController().getValue()==5.0) {
      for (int v = 1; v < 10; v++)
        leftarray[v] = 0;
      i = 1;
      j = 1;
      k = 8;
      l = 8;

      check1 = 5;
    }
    if (theEvent.getController().getValue()==6.0) {
      for (int v = 1; v < 10; v++)
        leftarray[v] = 0;
      i = 1;
      j = 1;
      k = 8;
      l = 8;

      check1 = 6;
    }

    if (theEvent.getController().getValue()==7.0) {
      for (int v = 1; v < 10; v++)
        leftarray[v] = 0;
      i = 1;
      j = 1;
      k = 8;
      l = 8;

      check1 = 7;
    }
  }
  if ( theEvent.getController().getName() == "RightList") {
    //check = (int)theEvent.getController().getValue();
    if (theEvent.getController().getValue()==0.0 ) {

      check2 = 0;

      i2 = 1;
      j2 = 1;
      k2 = 8;
      l2 = 8;
      for (int v = 1; v < 10; v++)
        rightarray[v] = 0;
    }

    if (theEvent.getController().getValue()==1.0) {

      check2 = 1;
      for (int v = 1; v < 10; v++)
        rightarray[v] = 0;
      i2 = 1;
      j2 = 1;
      k2 = 8;
      l2 = 8;
    }
    if (theEvent.getController().getValue()==2.0) {
      for (int v = 1; v < 10; v++)
        rightarray[v] = 0;
      i2 = 1;
      j2 = 1;
      k2 = 8;
      l2 = 8;

      check2 = 2;
    }
    if (theEvent.getController().getValue()==3.0) {
      for (int v = 1; v < 10; v++)
        rightarray[v] = 0;
      i2 = 1;
      j2 = 1;
      k2 = 8;
      l2 = 8;

      check2 = 3;
    }  
    if (theEvent.getController().getValue()==4.0) {
      for (int v = 1; v < 10; v++)
        rightarray[v] = 0;
      i2 = 1;
      j2 = 1;
      k2 = 8;
      l2 = 8;

      check2 = 4;
    }

    if (theEvent.getController().getValue()==5.0) {
      for (int v = 1; v < 10; v++)
        rightarray[v] = 0;
      i2 = 1;
      j2 = 1;
      k2 = 8;
      l2 = 8;

      check2 = 5;
    }
    if (theEvent.getController().getValue()==6.0) {
      for (int v = 1; v < 10; v++)
        rightarray[v] = 0;
      i2 = 1;
      j2 = 1;
      k2 = 8;
      l2 = 8;

      check2 = 6;
    }

    if (theEvent.getController().getValue()==7.0) {
      for (int v = 1; v < 10; v++)
        rightarray[v] = 0;
      i2 = 1;
      j2 = 1;
      k2 = 8;
      l2 = 8;

      check2 = 7;
    }
  }
}


void speed1(float cc) {

  timedelay1 = 1000 - cc * 50;
}

void Speed1forCenter(float cc) {

  timedelay3 = 1000 - cc * 50;
}

void speed2(float cc) {

  timedelay2 = 1000 - cc * 50;
}

void Speed2forCenter(float cc) {

  timedelay4 = 1000 - cc * 50;
}
  // create a function that customize droplist for left or right valves
void customize1(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.getCaptionLabel().set("function");
  ddl.addItem("Static", 1);
  ddl.addItem("circular clockwise", 2);
  ddl.addItem("circular counterclock wise", 3);
  ddl.addItem("pulsing", 4);
  ddl.addItem("left to right", 5);
  ddl.addItem("right to left", 6);
  ddl.addItem("bottom to top", 7);
  ddl.addItem("top to bottom", 8);
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}      
  // create a function that customize droplist for center valve
void customize2(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.getCaptionLabel().set("function");
  ddl.addItem("All on", 18);
  ddl.addItem("All off", 10);
  ddl.addItem("Pulsing", 12);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}  



void readSerial() {
  if (myPort.available() > 0) {
    String str =  myPort.readStringUntil('\n');
    if (str != null) {
      str = trim(str);
      String[] readings = str.split(" ");
      SERIAL_DATA = new float[readings.length];
      for (int i=0; i<readings.length; i++) {
        SERIAL_DATA[i] = parseFloat(readings[i]);
      }
    }
  }
}
void mouseReleased() {
  if (fileLoaded && player.position()>=player.length()) {          
    state = "PLAY";                                        //Resets song when it finishes.
  }
  if (mouseX>0 && mouseX<80 && mouseY < 40) {
    if (state == "PLAY" && fileLoaded) {                              
      state = "PAUSE";                                  //Plays song.
      player.play();
      player.setVolume(volume); //~~~~~~~~~~~~~~~~~~Volume?------------------\\
      for (int v = 1; v < 9; v++)
      leftarray[v] = 1;
    } else if (state == "PAUSE") {
      state = "PLAY";                                  //Pauses song.
      player.pause();
    }
  }

  if (mouseX>width-110 && mouseX<width && mouseY < 40) {
    selectInput("Select a file to process:", "fileSelected");    //Calls selectInput if button pressed.
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    String filepath = selection.getAbsolutePath();
    println("User selected " + filepath);
    // load file here
    player = minim.loadFile(filepath);
    fft = new FFT( player.bufferSize(), player.sampleRate());
    meta = player.getMetaData();
    fileLoaded = true;
    title = meta.title();
  }
}


void soundVision() {
  fft.forward( player.mix );

  fill(#45ADA8, soundVisionAlpha);
  stroke(grey);
  strokeWeight(1);


  if (progressBarAlpha<200 && soundVisionAlpha<255) {
    soundVisionAlpha+=3;
  } else if (soundVisionAlpha>50) {
    soundVisionAlpha-=5;
  }

  for (int i = 0; i < fft.specSize (); i+=5) {

    // draw the line for frequency band i, scaling it up a bit so we can see it
    colorMode(HSB);
    //stroke(i, 255, 255);

    //line( i, height, i, height - fft.getBand(i)*8 );



    rect(i+width/2, height - fft.getBand(i)*8, 10, height);
    //ellipse(i+width/2,height + 10 - fft.getBand(i)*5, 10,10);
  }

  for (int i = 0; i < fft.specSize (); i+=5) {

    // draw the line for frequency band i, scaling it up a bit so we can see it
    colorMode(HSB);
    //stroke(i, 255, 255);

    // strokeWeight(10);
    // stroke(#45ADA8,50);
    //fill(#45ADA8,20);
    //line( i+width/2, height, i+width/2, height - fft.getBand(i)*8 );


    rect(i, height - fft.getBand(i)*8, 10, height);
    //ellipse(i,height + 10 - fft.getBand(i)*5, 10,10);
  }
}


  
