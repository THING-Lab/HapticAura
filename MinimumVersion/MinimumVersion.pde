import controlP5.*;//import controlP5 library
ControlP5 cp5;
// Serial Port Output
import processing.serial.*; // Serial libraries, send OUTPUT through USB
Serial myPort;
int a = 0;
int b = 0;
int c = 0;
int d = 0;
int e = 0;
int f = 0;
int g = 0;
int h = 0;
int i = 1;
int j = 1;
int k = 8;
int l = 8;
int i2 = 1;
int j2 = 1;
int k2 = 8;
int l2 = 8;
int check1 = 0;
int check2 = 0;
int check3 = 1;
int check4 = 1;
int LRCount1 = 0;
int RLCount1 = 0;
int BTCount1 = 0;
int TBCount1 = 0;
int LRCount2 = 0;
int RLCount2 = 0;
int BTCount2 = 0;
int TBCount2 = 0;
int lastTime1 = 0;
int lastTime2 = 0;
int lastTime3 = 0;
int lastTime4 = 0;
int LeftCount  = 0;
int RightCount = 0;
int PulseCount1 = 0;
int PulseCount2 = 0;
int[] leftarray  = new int[10];
int[] rightarray = new int[10];
float timedelay1 = 100;
float timedelay2 = 100;
float timedelay3 = 100;
float timedelay4 = 100;
DropdownList d1;
DropdownList d2;
DropdownList d3;
DropdownList d4;

void setup() 
{ 
  size(800, 500);
  smooth();
  background(255);
  noStroke();
  myPort = new Serial(this, Serial.list()[4], 9600);
  myPort.bufferUntil('\n');
  cp5 = new ControlP5(this);
  fill(2);
  
  cp5.addSlider("speed1")
    .setPosition(100, 200)
    .setWidth(200)
    .setRange(0, 20)
    .setValue(10)
    ;

  cp5.addSlider("Speed1forCenter")
    .setPosition(100, 220)
    .setWidth(200)
    .setRange(0, 20)
    .setValue(10)
    ;  
    
  cp5.addSlider("speed2")
    .setPosition(500, 200)
    .setWidth(200)
    .setRange(0, 20)
    .setValue(10)
    ;

  cp5.addSlider("Speed2forCenter")
    .setPosition(500, 220)
    .setWidth(200)
    .setRange(0, 20)
    .setValue(10)
    ;  

  d1 = cp5.addDropdownList("LeftList")
    .setPosition(100, 10)
    .setSize(200, 180)
    ;

  customize1(d1);

  d2 = cp5.addDropdownList("RightList")
    .setPosition(500, 10)
    .setSize(200, 180)
    ;

  customize1(d2);

  d3 = cp5.addDropdownList("LeftCenter")
    .setPosition(20, 10)
    .setSize(70, 150)
    ;

  customize2(d3);
  
  d4 = cp5.addDropdownList("RightCenter")
    .setPosition(420, 10)
    .setSize(70, 150)
    ;
    
  customize2(d4);
  
}

void draw() 
{  
  background(222, 200, 255);
  stroke(0);
  fill(123, 123, 213);
  ellipse(190, 350, 200, 200);
  fill(150);
  ellipse(190, 350, 70, 70);
  
  if (leftarray[1] == 0)     //check the status of light on left circle if 0 is on or 1 is off. The light status is related to valves
  { 
    fill(0);
    ellipse(190, 270, 20, 20);
    myPort.write(1);   
  } 
  else 
  { 
    fill(255);
    ellipse(190, 270, 20, 20);
    myPort.write(2); 
  }
  
  if (leftarray[2] == 0) 
  { 
    fill(0);
    ellipse(246, 294, 20, 20);
    myPort.write(3);    
  } 
  else 
  {  
    fill(255);
    ellipse(246, 294, 20, 20);
    myPort.write(4);   
  }
  
  if (leftarray[3] == 0) 
  { 
    fill(0);
    ellipse(270, 350, 20, 20);
    myPort.write(5);  
  } 
  else 
  {  
    fill(255);
    ellipse(270, 350, 20, 20);
    myPort.write(6);  
  }
  
  if (leftarray[4] == 0) 
  {  
    fill(0);
    ellipse(246, 406, 20, 20);
    myPort.write(7);   
  } 
  else 
  {  
    fill(255);
    ellipse(246, 406, 20, 20);
    myPort.write(8);    
  }

  if (leftarray[5] == 0) 
  {  
    fill(0);
    ellipse(190, 430, 20, 20);
    myPort.write(9);   
  } 
  else 
  {
    fill(255);
    ellipse(190, 430, 20, 20);
    myPort.write(10);
  }
  
  if (leftarray[6] == 0) 
  {  
    fill(0);
    ellipse(134, 406, 20, 20);
    myPort.write(11);  
  } 
  else 
  {  
    fill(255);
    ellipse(134, 406, 20, 20);
    myPort.write(12);  
  }
  
  if (leftarray[7] == 0) 
  {  
    fill(0);
    ellipse(110, 350, 20, 20);
    myPort.write(13);   
  } 
  else 
  {  
    fill(255);
    ellipse(110, 350, 20, 20);
    myPort.write(14);
  }
 
  if (leftarray[8] == 0) 
  {  
    fill(0);
    ellipse(134, 294, 20, 20);
    myPort.write(15);   
  } 
  else 
  {  
    fill(255);
    ellipse(134, 294, 20, 20);
    myPort.write(16);   
  } 
 
  if (leftarray[9] == 0) 
  {     
    fill(0);
    ellipse(190, 350, 20, 20);
    myPort.write(33);  
  } 
  else 
  { 
    fill(255);
    ellipse(190, 350, 20, 20);
    myPort.write(34);  
  } 
  
  switch (check1)//check left animation choice
  {
      case 0 : //do static
          for (int v = 1; v < 9; v++)
            leftarray[v] = 0;  
          break;
      
      case 1 : //do clockwise animation   
          if (millis() - lastTime1 >= timedelay1) 
          {  
              if (j>1)
              {   
                leftarray[j-1] = 0;        
              }
              j++;
              leftarray[i] =1;      
              i++;
              if ( i == 9) 
              {
                i = 1;
              }
              if (j == 10) 
              {
                j = 2;
              }
            lastTime1= millis();   
          } 
          break;
  
 
      case 2 ://do counterclockwise animation  
          if (millis() - lastTime1 >= timedelay1) 
          {  
              if (l < 8)
              {
                leftarray[l+1] = 0;
              }
              l--;
              leftarray[k] =1;
              k--;
              if (k == 0) 
              {
                k = 8;
              }
              if (l == -1) 
              {
                l = 7;
              } 
            lastTime1= millis();  
          }
          break;

      case 3 : //do pulse animation     
          if (millis() - lastTime1 >= timedelay1) 
          {   
              switch(PulseCount1)
              {
                  case 0 :  
                      for (int b = 1; b < 5; b++ ) 
                      {
                        leftarray[2*b] = 1;
                      } 
                      PulseCount1++;
                      break;
         
                  case 1 :
                      for (int b = 1; b < 5; b++ ) 
                      {
                        leftarray[2*b] = 0;
                      }
                      PulseCount1++;
                      break;
                       
                  case 2 :    
                      for (int b = 1; b < 5; b++ ) 
                      {
                        leftarray[2*b-1] = 1;
                      }
                      PulseCount1++;
                      break;
                      
                  case 3 : 
                      for (int b = 1; b < 5; b++ ) 
                      {
                        leftarray[2*b-1] = 0;
                      }
                      PulseCount1 = 0;
                      break;
              }  
            lastTime1= millis();  
          }
          break;
  
      case 4 : //do left to right animation
          if (millis() - lastTime1 >= timedelay1) 
          {
              switch(LRCount1)  
              {
                  case 0 :  
                      leftarray[3] = 0;
                      leftarray[7] = 1; 
                      LRCount1++;
                      break;
                  
                  case 1 : 
                      leftarray[7] = 0;
                      leftarray[6] = 1;
                      leftarray[8] = 1;
                      LRCount1++;
                      break;
                      
                  case 2 : 
                      leftarray[6] = 0;
                      leftarray[8] = 0;
                      leftarray[1] = 1;
                      leftarray[5] = 1;
                      LRCount1++;
                      break;
                  
                  case 3 :      
                      leftarray[1] = 0;
                      leftarray[5] = 0;
                      leftarray[2] = 1;
                      leftarray[4] = 1;
                      LRCount1++;
                      break;
                      
                  case 4 :  
                      leftarray[2] = 0;
                      leftarray[4] = 0;
                      leftarray[3] = 1;
                      LRCount1 = 0;
                      break;
              }
            lastTime1= millis();
          }
          break;
          
      case 5 : //do right to left animation   
          if (millis() - lastTime1 >= timedelay1) 
          {
              switch (RLCount1)
              {
                  case 0 :    
                      leftarray[3] = 1;
                      leftarray[7] = 0;
                      RLCount1++;  
                      break;
                  
                  case 1 :           
                      leftarray[2] = 1;
                      leftarray[4] = 1;
                      leftarray[3] = 0;
                      RLCount1++;
                      break;
                  
                  case 2 : 
                      leftarray[1] = 1;
                      leftarray[5] = 1;
                      leftarray[2] = 0;
                      leftarray[4] = 0;
                      RLCount1++; 
                      break;   
                  
                  case 3 :          
                      leftarray[6] = 1;
                      leftarray[8] = 1;
                      leftarray[1] = 0;
                      leftarray[5] = 0;
                      RLCount1++;        
                      break; 
                   
                   case 4 : 
                      leftarray[7] = 1;
                      leftarray[6] = 0;
                      leftarray[8] = 0;
                      RLCount1 = 0;      
                      break;    
              }        
            lastTime1= millis(); 
          }
          break;
   
  
      case 6 : //do bottom to top animation
          if (millis() - lastTime1 >= timedelay1) 
          {
              switch (BTCount1)
              {
                  case 0 :   
                      leftarray[1] = 0;
                      leftarray[5] = 1;
                      BTCount1++;
                      break;
                  
                  case 1 :
                      leftarray[5] = 0;
                      leftarray[4] = 1;
                      leftarray[6] = 1;
                      BTCount1++;
                      break;
                  
                  case 2 : 
                      leftarray[4] = 0;
                      leftarray[6] = 0;
                      leftarray[3] = 1;
                      leftarray[7] = 1;
                      BTCount1++;    
                      break;
                      
                  case 3 : 
                      leftarray[3] = 0;
                      leftarray[7] = 0;
                      leftarray[2] = 1;
                      leftarray[8] = 1;
                      BTCount1++; 
                      break;
                      
                  case 4 : 
                      leftarray[2] = 0;
                      leftarray[8] = 0;
                      leftarray[1] = 1;
                      BTCount1 = 0;
                      break;
              }    
            lastTime1= millis(); 
          }
          break;
    
 
      case 7 ://do top to bottom animation   
          if (millis() - lastTime1 >= timedelay1) 
          {
              switch (TBCount1)
              { 
                  case 0 :  
                      leftarray[1] = 1;
                      leftarray[5] = 0;
                      TBCount1++;
                      break;
                   
                  case 1 :      
                      leftarray[2] = 1;
                      leftarray[8] = 1;
                      leftarray[1] = 0;
                      TBCount1 ++;
                      break;
                      
                  case 2 :   
                      leftarray[3] = 1;
                      leftarray[7] = 1;
                      leftarray[2] = 0;
                      leftarray[8] = 0;
                      TBCount1++;
                      break;
                  
                  case 3 :
                      leftarray[4] = 1;
                      leftarray[6] = 1;
                      leftarray[3] = 0;
                      leftarray[7] = 0;
                      TBCount1++;
                      break;
                      
                  case 4 :
                      leftarray[5] = 1;
                      leftarray[4] = 0;
                      leftarray[6] = 0;
                      TBCount1 = 0;
                      break;           
              }      
            lastTime1= millis(); 
          }
          break;
  }
  switch(check3)//check left center animation choice
  {        
      case 0:  //do left center on all the time  
          leftarray[9] = 1;    
          break;
     
      case 1: //do left center off all the time 
          leftarray[9] = 0;  
          break;
      
      case 2 : //do left center pulse  
          if (millis() - lastTime3 >= timedelay3) 
          {     
              if ( LeftCount == 0)
              {  
                leftarray[9] = 1;
                LeftCount++; 
              } 
              else 
              {  
                leftarray[9] = 0;
                LeftCount = 0; 
              }      
            lastTime3= millis();   
          }
          break;   
  }
  
  fill(123, 123, 213);
  ellipse(610, 350, 200, 200);
  fill(150);
  ellipse(610, 350, 70, 70);
  fill(0);
  
  if (rightarray[1] == 0) //check the right light status
  { 
    fill(0); 
    ellipse(610, 270, 20, 20);
    myPort.write(17);  
 
  } 
  else 
  {
    fill(255);
    ellipse(610, 270, 20, 20);
    myPort.write(18); 
  }
  
  if (rightarray[2] == 0) 
  { 
    fill(0);
    ellipse(666, 294, 20, 20);
    myPort.write(19);
  } 
  else 
  {
    fill(255);
    ellipse(666, 294, 20, 20);
    myPort.write(20); 
  }
  
  if (rightarray[3] == 0) 
  {  
    fill(0);
    ellipse(690, 350, 20, 20);
    myPort.write(21);
  } 
  else 
  {
    fill(255);
    ellipse(690, 350, 20, 20);
    myPort.write(22);  
  }
  
  if (rightarray[4] == 0) 
  {
    fill(0);
    ellipse(666, 406, 20, 20);
    myPort.write(23); 
  } 
  else 
  {
    fill(255);
    ellipse(666, 406, 20, 20);
    myPort.write(24);
  }
 
  if (rightarray[5] == 0) 
  {
    fill(0);
    ellipse(610, 430, 20, 20);
    myPort.write(25);
  } 
  else 
  {
    fill(255);
    ellipse(610, 430, 20, 20);
    myPort.write(26);
  }
  
  if (rightarray[6] == 0) 
  {
    fill(0);
    ellipse(554, 406, 20, 20);
    myPort.write(27);
  } 
  else 
  { 
    fill(255);
    ellipse(554, 406, 20, 20);
    myPort.write(28); 
  }
  
  if (rightarray[7] == 0) 
  {  
    fill(0);
    ellipse(530, 350, 20, 20);
    myPort.write(29);
  } 
  else 
  {
    fill(255);
    ellipse(530, 350, 20, 20);
    myPort.write(30); 
  }
 
  if (rightarray[8] == 0) 
  {
    fill(0);
    ellipse(554, 294, 20, 20);
    myPort.write(31);
  } 
  else 
  {
    fill(255);
    ellipse(554, 294, 20, 20);
    myPort.write(32); 
  }
  
  if (rightarray[9] == 0) 
  {
    fill(0);
    ellipse(610, 350, 20, 20);
    myPort.write(32);
  } 
  else 
  {
    fill(255);
    ellipse(610, 350, 20, 20);
    myPort.write(32);
  }  

  switch (check2) 
  {
      case 0 : //do right static
          for (int v = 1; v < 9; v++)
            rightarray[v] = 0; 
          break;
  
      case 1 : //do clockwise animation
          if (millis() - lastTime2 >= timedelay2) 
          {     
              if (j2>1) 
              {
                rightarray[j2-1] = 0;
              }
              j2++;
              rightarray[i2] =1;
              i2++;
              if (i2 == 9) 
              {
                i2 = 1;
              }        
              if (j2 == 10) 
              {
                j2 = 2;
              }
            lastTime2= millis();
          }
          break;
  
      case 2 : //do counterclockwise animation
          if (millis() - lastTime2 >= timedelay2) 
          {
              if (l2 < 8) 
              {
                rightarray[l2+1] = 0;
              }
              l2--;
              rightarray[k2] =1;
              k2--;
              if ( k2 == 0) 
              {
                k2 = 8;
              }
              if (l2 == -1) 
              {
                l2 = 7;
              }
            lastTime2= millis();
          }
          break;
  
       case 3 : //do pulse
           if (millis() - lastTime2 >= timedelay2) 
           {
               switch(PulseCount2)
               {
                   case 0 :
                       for (int b = 1; b < 5; b++ ) 
                       {
                         rightarray[2*b] = 1;
                       }
                       PulseCount2++;
                       break;
            
                   case 1 : 
                       for (int b = 1; b < 5; b++ ) 
                       {
                         rightarray[2*b] = 0;
                       }
                       PulseCount2++;
                       break;
             
                   case 2 :
                       for (int b = 1; b < 5; b++ ) 
                       {
                         rightarray[2*b-1] = 1;
                       }
                       PulseCount2++;
                       break;
             
                   case 3 : 
                       for (int b = 1; b < 5; b++ ) 
                       {
                         rightarray[2*b-1] = 0;
                       }
                       PulseCount2 = 0;
                       break;
              }
             lastTime2= millis();
           }
           break;
               
       case 4 : //do left to right
           if (millis() - lastTime2 >= timedelay2) 
           {
               switch(LRCount2)
               {
                   case 0 : 
                       rightarray[3] = 0;
                       rightarray[7] = 1; 
                       LRCount2++;
                       break;
           
                   case 1 :  
                       rightarray[7] = 0;          
                       rightarray[6] = 1;         
                       rightarray[8] = 1;         
                       LRCount2++;
                       break;
                  
                   case 2 :   
                       rightarray[6] = 0;        
                       rightarray[8] = 0;          
                       rightarray[1] = 1;         
                       rightarray[5] = 1;
                       LRCount2++;
                       break;
                        
                   case 3 :     
                       rightarray[1] = 0;          
                       rightarray[5] = 0;          
                       rightarray[2] = 1;          
                       rightarray[4] = 1;         
                       LRCount2++;
                       break;
        
                   case 4 :      
                       rightarray[2] = 0;          
                       rightarray[4] = 0;          
                       rightarray[3] = 1;          
                       LRCount2 = 0;
                       break;
                }
              lastTime2= millis();
          }
          break;
          
      case 5 : //do right to left 
          if (millis() - lastTime2 >= timedelay2) 
          {
              switch (RLCount2)
              {
                  case 0: 
                      rightarray[3] = 1;      
                      rightarray[7] = 0;     
                      RLCount2++;
                      break;
                  
                  case 1:
                      rightarray[2] = 1; 
                      rightarray[4] = 1;          
                      rightarray[3] = 0;          
                      RLCount2++;
                      break;
                      
                  case 2:
                      rightarray[1] = 1;
                      rightarray[5] = 1;
                      rightarray[2] = 0;
                      rightarray[4] = 0;
                      RLCount2++;
                      break;
                      
                  case 3:
                      rightarray[6] = 1;
                      rightarray[8] = 1; 
                      rightarray[1] = 0;
                      rightarray[5] = 0;
                      RLCount2++;
                      break;
                 
                  case 4 :
                      rightarray[7] = 1;          
                      rightarray[6] = 0;         
                      rightarray[8] = 0;        
                      RLCount2 = 0;
                      break;
              }
            lastTime2= millis();
          }
          break;
  
      case 6 : //do bottom to top
          if (millis() - lastTime2 >= timedelay2) 
          {
              switch (BTCount2) 
              {
                  case 0 :
                      rightarray[1] = 0;         
                      rightarray[5] = 1;          
                      BTCount2++;
                      break;
                  
                  case 1 :       
                      rightarray[5] = 0;
                      rightarray[4] = 1;
                      rightarray[6] = 1;
                      BTCount2++;
                      break;
            
                  case 2 :      
                      rightarray[4] = 0;        
                      rightarray[6] = 0;          
                      rightarray[3] = 1;         
                      rightarray[7] = 1;         
                      BTCount2++;
                      break;
          
                  case 3 :      
                      rightarray[3] = 0;          
                      rightarray[7] = 0;          
                      rightarray[2] = 1;         
                      rightarray[8] = 1;         
                      BTCount2++;
                      break; 
         
                  case 4 :    
                      rightarray[2] = 0;       
                      rightarray[8] = 0;       
                      rightarray[1] = 1;                          
                      BTCount2 = 0;
                      break;
              }
            lastTime2= millis();
          }
          break;
 
      case 7 : //do top to bottom
          if (millis() - lastTime2 >= timedelay2) 
          {
              switch (TBCount2) 
              {
                  case 0 : 
                      rightarray[1] = 1;          
                      rightarray[5] = 0;                        
                      TBCount2++;
                      break;
                      
                  case 1 :       
                      rightarray[2] = 1;          
                      rightarray[8] = 1;          
                      rightarray[1] = 0;          
                      TBCount2 ++;
                      break;
                      
                  case 2 :      
                      rightarray[3] = 1;        
                      rightarray[7] = 1;          
                      rightarray[2] = 0;          
                      rightarray[8] = 0;    
                      TBCount2++;
                      break;
                  
                  case 3 :      
                      rightarray[4] = 1;
                      rightarray[6] = 1;
                      rightarray[3] = 0;
                      rightarray[7] = 0;
                      TBCount2++;
                      break;
                  
                  case 4 :                  
                      rightarray[5] = 1;
                      rightarray[4] = 0;
                      rightarray[6] = 0;
                      TBCount2 = 0;
                      break;    
              }        
            lastTime2= millis();
          }
          break;
  }
  
  switch (check4) //control the right center animation
  { 
      case 0 :  
          rightarray[9] = 1;  
          break;
 
      case 1: 
          rightarray[9] = 0;
          break;
          
      case 2: 
          if (millis() - lastTime4 >= timedelay4) 
          {
              if ( RightCount == 0)
              {
                rightarray[9] = 1;
                RightCount++;
              }
              else
              {
                rightarray[9] = 0;
                RightCount = 0;
              }
            lastTime4= millis();
          }
          break;
  }

}

void controlEvent(ControlEvent theEvent) 
{
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.
  println("event from controller : "+theEvent.getController().getName() +" from "+theEvent.getController());
  println(theEvent.getController());
  
  if ( theEvent.getController().getName() == "LeftCenter") 
  {
      switch (int(theEvent.getController().getValue()))
      {
          case 0 :
              check3 = 0;
              break;
          
          case 1 :
              check3 = 1;
              break;
          
          case 2 :
              check3 = 2;
              break;
      }
  } 
  
  if ( theEvent.getController().getName() == "RightCenter") 
  {
      switch (int(theEvent.getController().getValue()))
      {
          case 0 :
              check4 = 0;
              break;
          
          case 1 :
              check4 = 1;
              break;
          
          case 2 :
              check4 = 2;
              break;
      }     
  } 

  if ( theEvent.getController().getName() == "LeftList") 
  {
      switch (int(theEvent.getController().getValue()))
      {
          case 0 :             
              for (int v = 1; v < 10; v++)
                leftarray[v] = 0;  
              i = 1;
              j = 1;
              k = 8;
              l = 8;
              check1 = 0;            
              break;
          
          case 1 :             
              for (int v = 1; v < 10; v++)
                leftarray[v] = 0;
              i = 1;
              j = 1;
              k = 8;
              l = 8;
              check1 = 1;
              break;
          
          case 2 :
              for (int v = 1; v < 10; v++)
                leftarray[v] = 0;
              i = 1;
              j = 1;
              k = 8;
              l = 8;
              check1 = 2;
              break;
              
          case 3 :
              for (int v = 1; v < 10; v++)
                leftarray[v] = 0;
              i = 1;
              j = 1;
              k = 8;
              l = 8;
              check1 = 3;
              break;
          
          case 4 :
              for (int v = 1; v < 10; v++)
                leftarray[v] = 0;
              i = 1;
              j = 1;
              k = 8;
              l = 8;
              check1 = 4;           
              break;
          
          case 5 :
              for (int v = 1; v < 10; v++)
                leftarray[v] = 0;
              i = 1;
              j = 1;
              k = 8;
              l = 8;
              check1 = 5;             
              break;
      
          case 6 :
              for (int v = 1; v < 10; v++)
                leftarray[v] = 0;
              i = 1;
              j = 1;
              k = 8;
              l = 8;
              check1 = 6;
              break;
        
          case 7 :
              for (int v = 1; v < 10; v++)
                leftarray[v] = 0;
              i = 1;
              j = 1;
              k = 8;
              l = 8;
              check1 = 7;
              break;
      }   
  }
  
  
  if ( theEvent.getController().getName() == "RightList") 
  {
      switch (int(theEvent.getController().getValue()))
      {
          case 0 :             
              for (int v = 1; v < 10; v++)
                rightarray[v] = 0; 
              i2 = 1;
              j2 = 1;
              k2 = 8;
              l2 = 8;
              check2 = 0;
              break;
          
          case 1 :             
              for (int v = 1; v < 10; v++)
                rightarray[v] = 0;
              i = 1;
              j = 1;
              k = 8;
              l = 8;
              check2 = 1;
              break;
          
          case 2 :
              for (int v = 1; v < 10; v++)
                rightarray[v] = 0;
              i = 1;
              j = 1;
              k = 8;
              l = 8;
              check2 = 2;
              break;
              
          case 3 :
              for (int v = 1; v < 10; v++)
                rightarray[v] = 0;
              i = 1;
              j = 1;
              k = 8;
              l = 8;
              check2 = 3;
              break;
          
          case 4 :
              for (int v = 1; v < 10; v++)
                rightarray[v] = 0;
              i = 1;
              j = 1;
              k = 8;
              l = 8;
              check2 = 4;           
              break;
          
          case 5 :
              for (int v = 1; v < 10; v++)
                rightarray[v] = 0;
              i = 1;
              j = 1;
              k = 8;
              l = 8;
              check2 = 5;             
              break;
      
          case 6 :
              for (int v = 1; v < 10; v++)
                rightarray[v] = 0;
              i = 1;
              j = 1;
              k = 8;
              l = 8;
              check2 = 6;
              break;
        
          case 7 :
              for (int v = 1; v < 10; v++)
                rightarray[v] = 0;
              i = 1;
              j = 1;
              k = 8;
              l = 8;
              check2 = 7;
              break;
      }   
  }

}
      
  

//adjust all the speed related to timedelay 
void speed1(float cc) 
{
  timedelay1 = 1000 - cc * 50;
}

void Speed1forCenter(float cc) 
{
  timedelay3 = 1000 - cc * 50;
}

void speed2(float cc) 
{
  timedelay2 = 1000 - cc * 50; 
}

void Speed2forCenter(float cc)
{
  timedelay4 = 1000 - cc * 50;
}

void customize1(DropdownList ddl) 
{ 
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
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));

} 

void customize2(DropdownList ddl) 
{
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
