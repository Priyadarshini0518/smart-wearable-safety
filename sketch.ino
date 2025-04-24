#define BUTTON_PIN 4
#define LED_PIN 2

bool alertSent = false;

void setup() {
  Serial.begin(115200);
  pinMode(BUTTON_PIN, INPUT_PULLUP);
  pinMode(LED_PIN, OUTPUT);
  digitalWrite(LED_PIN, LOW);
}

void loop() {
  if (digitalRead(BUTTON_PIN) == LOW && !alertSent) {
    Serial.println("SOS ALERT TRIGGERED!");
    Serial.println("Simulated Location: 12.9716, 77.5946");
    digitalWrite(LED_PIN, HIGH); // simulate vibration or buzzer
    alertSent = true;
    delay(3000);
    }
}