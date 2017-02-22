#include <Wire.h>
#include <Adafruit_MotorShield.h>

const int leftLightPin  = A2;  //define a pin for left Photo resistor
const int rightLightPin = A3;  //define a pin for right Photo resistor
const int leftLedPin  = 2;
const int rightLedPin = 3;

int leftLightZero;
int rightLightZero;
const int threshold = 50;

// Configuration des deux moteurs: gauche sur M1 et M2, droite sur M3 et M4
Adafruit_MotorShield AFMS = Adafruit_MotorShield(); 
Adafruit_StepperMotor *leftMotor  = AFMS.getStepper(200, 1);
Adafruit_StepperMotor *rightMotor = AFMS.getStepper(200, 2);

void setup() {
  // Initialization du port serie pour deboggage
  Serial.begin(9600);
  
  // Configuration: connecteurs d'entree et de sortie, moteurs
  pinMode(leftLedPin,  OUTPUT);  
  pinMode(rightLedPin, OUTPUT);  
  pinMode(leftLightPin,  INPUT);  
  pinMode(rightLightPin, INPUT);
  AFMS.begin();
  
  // Allumage des leds de direction  
  digitalWrite(leftLedPin, HIGH);
  digitalWrite(rightLedPin, HIGH);

  // Calibration des capteurs de lumiere:
  // moyenne sur 100 mesures, avec lampes allumees et moteur
  // qui tourne pour tenir compte de l'affaiblissement de
  // l'eclairage a pleine puissance
  int n = 100;
  long leftSum = 0;
  long rightSum = 0;
  for (int i=0; i<n; i++) {
    leftSum  += analogRead(leftLightPin);
    rightSum += analogRead(rightLightPin);
    leftMotor ->onestep(FORWARD, DOUBLE);
    rightMotor->onestep(FORWARD, DOUBLE);
  }
  leftLightZero = leftSum / n;
  rightLightZero = rightSum / n;
}

int i = 0;

// the loop routine runs over and over again forever:
void loop() {
  // Read light values
  int leftLight  = analogRead(leftLightPin ) - leftLightZero;
  int rightLight = analogRead(rightLightPin) - rightLightZero;

  if (Serial and i%10 == 0) {
    // Print debugging info on serial line once every 10 steps
    Serial.print(rightLight-leftLight);
    Serial.print("\t");
    Serial.print(leftLight);
    Serial.print("+");
    Serial.print(leftLightZero);
    Serial.print("\t");
    Serial.print(rightLight);
    Serial.print("+");
    Serial.println(rightLightZero);
  }
  i++;

  // Commande des moteurs et lumieres
  if (leftLight < - threshold) {
    // Le sol est sombre a gauche.
    // On eteint le moteur gauche pour tourner a gauche
    digitalWrite(leftLedPin, LOW);
  } else {
    digitalWrite(leftLedPin, HIGH);
    leftMotor ->onestep(FORWARD, DOUBLE);
  }

  if (rightLight < - threshold) {
    // Le sol est sombre a droite.
    // On eteint le moteur droite pour tourner a droite
    digitalWrite(rightLedPin, LOW);
  } else {
    digitalWrite(rightLedPin, HIGH);
    rightMotor ->onestep(FORWARD, DOUBLE);
  }
}
