int ledY = 11;
int ledX = 10;
int ledXY = 3;
int led_XY = 9;
int ledPressed = 4; 
int isKeyPressed = 8;
int input_X = 0;
int input_Y = 1;
const byte numOfInputsForNoiseRemoving = 8;
byte tempNumOfInputsForNoiseRemoving = 8;
byte X_s[numOfInputsForNoiseRemoving] __attribute__((used));
byte Y_s[numOfInputsForNoiseRemoving] __attribute__((used));
byte counter = 0;
int pressedState = 0;
byte sumX  __attribute__((used));
byte sumY  __attribute__((used));
byte avgX = 0;
byte avgY = 0;
int errorAxis = 2;
int error = 40;  
int pressed = 0;
int avg2X = 0;
int avg2Y = 0;

void setup(){
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(ledY, OUTPUT);
  pinMode(ledX, OUTPUT);
  pinMode(ledXY, OUTPUT);
  pinMode(led_XY, OUTPUT);
  pinMode(ledPressed, OUTPUT);
  pinMode(isKeyPressed, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  byte tempX = (analogRead(input_X) / 8);
  delay(50);
  byte tempY = (analogRead(input_Y) / 8);

  Serial.println("tempX");
  Serial.println(tempX);
  Serial.println("tempY");
  Serial.println(tempY);
  asm volatile(
    "mov r21 , %0 \n\t" // r21 = counter%numOfInputsForNoiseRemoving
    "mov r22 , %1 \n\t"
    "modLoop: \n\t"
    "cp r21 , r22  \n\t"
    "brlt endModLoop \n\t"
    "sub r21 , r22 \n\t"
    "jmp modLoop \n\t"
    "endModLoop: \n\t"
    "mov %0 , r21\n\t" 

    "ldi r30, lo8(X_s) \n\t "
    "ldi r31, hi8(X_s) \n\t"
     
    "add r30, r21 \n\t"
    "st z , %2 \n\t"

    "ldi r30, lo8(Y_s) \n\t "
    "ldi r31, hi8(Y_s) \n\t"
     
    "add r30, r21 \n\t"
    "st z , %3 \n\t"



    "eor r3 , r3\n\t"//Low
    "eor r21 , r21\n\t"//HI
    "eor r20 , r20\n\t" 
    "ldi r22 , 1 \n\t"
    "loop: \n\t"
    "cp r20 , %1 \n\t"
    "breq exitLoop \n\t"
    "ldi r30, lo8(X_s) \n\t "
    "ldi r31, hi8(X_s) \n\t"
    "add r30, r20 \n\t"
    "ld r5 , z \n\t"
    "add r3 , r5\n\t"
    "adc r21 , __zero_reg__ \n\t"
    "add r20 , r22\n\t"
    "jmp loop\n\t"
    "exitLoop: \n\t"
    "lsl r21 \n\t"
    "lsl r21 \n\t"
    "lsl r21 \n\t"
    "lsl r21 \n\t"
    "lsl r21 \n\t"
    "lsr r3 \n\t"
    "lsr r3 \n\t"
    "lsr r3 \n\t"        
    "or r3 , r21 \n\t"

    "mov %6 , r3 \n\t"

    "eor r3 , r3\n\t"//Low
    "eor r21 , r21\n\t"//HI
    "eor r20 , r20\n\t" 
    "ldi r22 , 1 \n\t"
    "loop2: \n\t"
    "cp r20 , %1 \n\t"
    "breq exitLoop2 \n\t"
    "ldi r30, lo8(Y_s) \n\t "
    "ldi r31, hi8(Y_s) \n\t"
    "add r30, r20 \n\t"
    "ld r5 , z \n\t"
    "add r3 , r5\n\t"
    "adc r21 , __zero_reg__ \n\t"
    "add r20 , r22\n\t"
    "jmp loop2\n\t"
    "exitLoop2: \n\t"
    "lsl r21 \n\t"
    "lsl r21 \n\t"
    "lsl r21 \n\t"
    "lsl r21 \n\t"
    "lsl r21 \n\t"
    "lsr r3 \n\t"
    "lsr r3 \n\t"
    "lsr r3 \n\t"        
    "or r3 , r21 \n\t"

    "mov %7 , r3 \n\t"

    "add %0 , r22\n\t"
    : "+r" (counter) ,"+a" (tempNumOfInputsForNoiseRemoving), "+r" (tempX) , "+r" (tempY) , "+r" (sumX) , "+r" (sumY) , "+r" (avgX) , "+r" (avgY) 
    :
    //"0" (counter), "1" (tempNumOfInputsForNoiseRemoving) , "2" (tempX) , "3" (tempY) , "4" (sumX) , "5" (sumY) , "6" (avgX) , "7" (avgY)
    : "r30", "r31" , "r1" , "r2" , "r3" , "r4" , "r5" , "r21" , "r22"
    );
        
//    for (int i = 0; i < numOfInputsForNoiseRemoving; i++){  
//      sumX += X_s[i];
//      sumY += Y_s[i];
//    } 
//    avgX = sumX/numOfInputsForNoiseRemoving;
//    avgY = sumY/numOfInputsForNoiseRemoving;
//  }

//    Serial.println(sumX);
//    Serial.println(avgX);
//    avgX *= 8;
//    avgY *= 8;
    
    Serial.println("counter");
    //Serial.println("part3");
//      counter += 1;
    Serial.println(counter);
    Serial.println("X[0]");
    Serial.println(X_s[0]);
    Serial.println("X[1]");
    Serial.println(X_s[1]);
    Serial.println("X[2]");
    Serial.println(X_s[2]);
    Serial.println("X[3]");
    Serial.println(X_s[3]);
    Serial.println("X[4]");
    Serial.println(X_s[4]);
    Serial.println("X[5]");
    Serial.println(X_s[5]);
    Serial.println("X[6]");
    Serial.println(X_s[6]);
    Serial.println("X[7]");
    Serial.println(X_s[7]);

    avg2X = 1 * avgX;
    avg2Y = 1 * avgY;
    Serial.println("avgX");
    Serial.println(avgX);
    Serial.println("avgY");
    Serial.println(avgY);
    
    
  if (avg2X < 64 + errorAxis && avg2X > 64 - errorAxis){
//      Serial.println("outIf1");
    if (avg2Y < 64 + errorAxis && avg2Y > 64 - errorAxis){
//      Serial.println("inIf1");
      int on = 255;
      analogWrite(ledY, 2*avgY);
      analogWrite(ledX, 2*avgY);
      analogWrite(ledXY, 2*avgY);
      analogWrite(led_XY, 2*avgY); 
    }
    else{
//      Serial.println("inIf2");
      analogWrite(ledY, 2*avgY);
      analogWrite(ledX, 0);
      analogWrite(ledXY, 0);
      analogWrite(led_XY, 0); 
    }
  }
  else if (avg2Y < 64 + errorAxis && avg2Y > 64 - errorAxis){
//    Serial.println("outIf2");
    analogWrite(ledX, 2*avgX);
    analogWrite(ledY, 0);
    analogWrite(ledXY, 0);
    analogWrite(led_XY, 0);
  }
  else if (avg2X - avg2Y < error && avg2X - avg2Y > -error){
//    Serial.println("outIf3");
    analogWrite(ledXY, 2*avgY);
    analogWrite(ledX, 0);
    analogWrite(ledY, 0);
    analogWrite(led_XY, 0);
  }
  else if (avg2X + avg2Y < 128 + error && avg2Y + avg2X > 128 - error){
//    Serial.println("outIf4");
    analogWrite(led_XY, 2*avgY);
    analogWrite(ledX, 0);
    analogWrite(ledXY, 0);
    analogWrite(ledY, 0);
  }
  if (digitalRead(isKeyPressed) == LOW && pressed == 0){
    pressed = 1;
    pressedState = (pressedState == 1)?0:1;
    if (pressedState == 1){
      digitalWrite(ledPressed, HIGH);
    }
    else{
      digitalWrite(ledPressed, LOW);
    }
  }
  else if (digitalRead(isKeyPressed) == HIGH){
    pressed = 0;
  }
}
