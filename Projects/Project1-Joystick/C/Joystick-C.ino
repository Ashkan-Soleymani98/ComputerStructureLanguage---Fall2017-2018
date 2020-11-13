int ledY = 11;
int ledX = 10;
int ledXY = 3;
int led_XY = 9;
int ledPressed = 4; 
int isKeyPressed = 8;
int input_X = 0;
int input_Y = 1;
const int numOfInputsForNoiseRemoving = 5;
int X_s[numOfInputsForNoiseRemoving];
int Y_s[numOfInputsForNoiseRemoving];
int counter = 0;
int pressedState = 0;
int sumX, sumY, avgX, avgY;
int errorAxis = 10;
int error = 200;  
int pressed = 0;

void setup() {
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
  int tempX = analogRead(input_X);
  delay(50);
  int tempY = analogRead(input_Y);
  
  if (counter < numOfInputsForNoiseRemoving){
    X_s[counter] = tempX;
    Y_s[counter] = tempY;
  }
  else{
    
    X_s[counter%numOfInputsForNoiseRemoving] = tempX;
    Y_s[counter%numOfInputsForNoiseRemoving] = tempY;
    
    for (int i = 0; i < numOfInputsForNoiseRemoving; i++){
      if (i == 0){
        sumX = 0; 
        sumY = 0;
      }
      sumX += X_s[i];
      sumY += Y_s[i];
      if (i == numOfInputsForNoiseRemoving - 1){
        avgX = sumX/numOfInputsForNoiseRemoving;
        avgY = sumY/numOfInputsForNoiseRemoving;
      }
    }
  }
  
  counter += 1;
  
  if (avgX < 512 + errorAxis && avgX > 512 - errorAxis){
    if (avgY < 512 + errorAxis && avgY > 512 - errorAxis){
      analogWrite(ledY, avgY/4);
      analogWrite(ledX, avgY/4);
      analogWrite(ledXY, avgY/4);
      analogWrite(led_XY, avgY/4); 
    }
    else{
      analogWrite(ledY, avgY/4);
      analogWrite(ledX, 0);
      analogWrite(ledXY, 0);
      analogWrite(led_XY, 0); 
    }
  }
  else if (avgY < 512 + errorAxis && avgY > 512 - errorAxis){
    analogWrite(ledX, avgX/4);
    analogWrite(ledY, 0);
    analogWrite(ledXY, 0);
    analogWrite(led_XY, 0);
  }
  else if (avgX - avgY < error && avgX - avgY > -error){
    analogWrite(ledXY, avgY/4);
    analogWrite(ledX, 0);
    analogWrite(ledY, 0);
    analogWrite(led_XY, 0);
  }
  else if (avgX + avgY < 1024 + error && avgY + avgX > 1024 - error){
    analogWrite(led_XY, avgY/4);
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
