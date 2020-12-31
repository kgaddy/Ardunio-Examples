/*Example sketch to control a stepper motor with A4988/DRV8825 stepper motor driver and Arduino without a library. More info: https://www.makerguides.com */

// Define stepper motor connections and steps per revolution:
#define dirPin 2
#define stepPin 3
#define stepsPerRevolution 500
#define grindSpeed 700

void setup() {
  // Declare pins as output:
  pinMode(stepPin, OUTPUT);
  pinMode(dirPin, OUTPUT);
  delay(1000);
}

void loop() {
  // Set the spinning direction clockwise:
  digitalWrite(dirPin, HIGH);

  // Set the spinning direction counterclockwise:
  digitalWrite(dirPin, LOW);

  // Spin the stepper motor 1 revolution quickly:
  for (int i = 0; i < stepsPerRevolution; i++) {
  
    // These four lines result in 1 step:
    digitalWrite(stepPin, HIGH);
    delayMicroseconds(grindSpeed);
    digitalWrite(stepPin, LOW);
    delayMicroseconds(grindSpeed);
  }

  delay(200);

   // Set the spinning direction clockwise:
  digitalWrite(dirPin, HIGH);

    // Spin the stepper motor 1 revolution quickly:
  for (int i = 0; i < stepsPerRevolution; i++) {
    // These four lines result in 1 step:
    digitalWrite(stepPin, HIGH);
    delayMicroseconds(grindSpeed);
    digitalWrite(stepPin, LOW);
    delayMicroseconds(grindSpeed);
  }
  delay(200);
}
