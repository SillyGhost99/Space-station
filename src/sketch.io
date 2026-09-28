#include <Wire.h>
#include <DHT.h>
#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include <ESP32Servo.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

// Pin definitions
#define DHTPIN 4
#define DHTTYPE DHT22
#define TRIG_PIN 27
#define ECHO_PIN 26
#define SERVO1_PIN 13   // docking hatch
#define SERVO2_PIN 12   // solar tracking
#define BUZZER_PIN 2
#define MQ135_PIN 34
#define LDR1_PIN 32
#define LDR2_PIN 33

#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64

DHT dht(DHTPIN, DHTTYPE);
Adafruit_MPU6050 mpu;
Servo dockServo;
Servo solarServo;
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, -1);

int solarAngle = 90; // starting midpoint
const int CO2_THRESHOLD = 2000; // tune this after testing with the sim potentiometer

void setup() {
  Serial.begin(115200);
  dht.begin();
  Wire.begin();

  if (!mpu.begin()) {
    Serial.println("MPU6050 not found!");
  }

  if (!display.begin(SSD1306_SWITCHCAPVCC, 0x3C)) {
    Serial.println("OLED not found!");
  }
  display.clearDisplay();
  display.setTextColor(SSD1306_WHITE);

  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  pinMode(BUZZER_PIN, OUTPUT);

  dockServo.attach(SERVO1_PIN);
  solarServo.attach(SERVO2_PIN);
  solarServo.write(solarAngle);
}

long readUltrasonicDistance() {
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);
  long duration = pulseIn(ECHO_PIN, HIGH);
  return duration * 0.034 / 2; // cm
}

void updateSolarTracking() {
  int leftLight = analogRead(LDR1_PIN);
  int rightLight = analogRead(LDR2_PIN);
  int diff = leftLight - rightLight;

  if (abs(diff) > 50) { // deadband to avoid jitter
    if (diff > 0 && solarAngle < 180) solarAngle += 2;
    else if (diff < 0 && solarAngle > 0) solarAngle -= 2;
    solarServo.write(solarAngle);
  }
}

void checkAirQuality() {
  int mq135Value = analogRead(MQ135_PIN);
  if (mq135Value > CO2_THRESHOLD) {
    digitalWrite(BUZZER_PIN, HIGH);
    // TODO: trigger ventilation fan via L298N here
  } else {
    digitalWrite(BUZZER_PIN, LOW);
  }
}

void updateDisplay(float temp, float hum, int mq135Value, long distance) {
  display.clearDisplay();
  display.setCursor(0, 0);
  display.setTextSize(1);
  display.print("Temp: "); display.print(temp); display.println(" C");
  display.print("Hum: "); display.print(hum); display.println(" %");
  display.print("Air Q: "); display.println(mq135Value);
  display.print("Dist: "); display.print(distance); display.println(" cm");
  display.display();
}

void loop() {
  float temp = dht.readTemperature();
  float hum = dht.readHumidity();
  int mq135Value = analogRead(MQ135_PIN);
  long distance = readUltrasonicDistance();

  updateSolarTracking();
  checkAirQuality();
  updateDisplay(temp, hum, mq135Value, distance);

  Serial.print("Temp: "); Serial.print(temp);
  Serial.print(" | Hum: "); Serial.print(hum);
  Serial.print(" | AirQ: "); Serial.print(mq135Value);
  Serial.print(" | Dist: "); Serial.println(distance);

  delay(1000);
}
