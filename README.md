#  AETHER-1 — Autonomous Environmental & Telemetry Hub for Extended Research

> A Tiangong-inspired modular space station prototype built for Smart India Hackathon.  
> Detects, responds to, and predicts environmental anomalies in microgravity habitats — powered by ESP32, real sensor telemetry, CFD simulation, and optional ML inference.

---

## Problem Statement

In crewed space stations, microgravity causes CO₂ to form invisible stagnant pockets near sleeping and working zones — unlike on Earth where convection naturally circulates air. These pockets are invisible, silent, and dangerous. Current detection systems are expensive, centralized, and reactive.

**AETHER-1** is a low-cost, modular, edge-deployable prototype that detects CO₂ stagnation, triggers ventilation response, logs environmental telemetry, and optionally predicts anomalies before they occur using onboard ML inference.

---

##  Architecture

```
┌────────────────────────────────────────────────┐
│              AETHER-1 Core Module              │
│                                                │
│   ESP32 ──► Sensor Array ──► Local Dashboard  │
│               │                               │
│           WiFi/MQTT                           │
│               │                               │
│         Python Backend ──► Web Dashboard      │
│               │                               │
│         [Optional] ML Inference Layer         │
└────────────────────────────────────────────────┘
```

**Physical Layout:** T-shaped modular body inspired by Tiangong's core + side module architecture. Core module houses compute and sensors. Side modules represent lab and sleep zones.

---

## Hardware Stack

| Component | Role |
|-----------|------|
| ESP32 | Main microcontroller, WiFi telemetry |
| DHT22 | Temperature & Humidity sensing |
| MPU6050 | Orientation & vibration (microgravity simulation) |
| MQ135 | Air quality / CO₂ approximation |
| Solar Panel + TP4056 | Solar recharge simulation |
| Li-Po Battery | Power simulation for off-grid operation |
| OLED Display | Local status readout |
| Mini Fan (PWM) | Ventilation response actuator |

**Estimated Budget: ₹1,500 – ₹2,000**

---

##  Features

### Core (Implemented)
- [x] Real-time temperature, humidity, air quality sensing
- [x] Orientation and vibration logging via MPU6050
- [x] Automatic ventilation trigger on CO₂ threshold breach
- [x] Solar panel charge monitoring
- [x] Local OLED status display
- [x] WiFi telemetry over MQTT
- [x] Python dashboard — live plots of all sensor streams
- [x] Wokwi simulation for hardware validation
- [x] CFD visualization of CO₂ stagnation zones (simulation software)

### Optional — ML Extension *(SIH Enhanced Version)*
- [ ] Anomaly detection model trained on sensor time-series data
- [ ] Predictive ventilation — triggers fan before threshold is breached
- [ ] Sensor fusion using MPU6050 + MQ135 for zone-level CO₂ mapping
- [ ] LSTM or lightweight TFLite model for onboard inference on ESP32
- [ ] Streamlit dashboard with ML prediction overlay
- [ ] Data logging pipeline — CSV → Pandas → model retraining loop

### Optional — Extended Features
- [ ] GPS module integration for navigation simulation display
- [ ] Multi-zone sensor network (multiple ESP32 nodes, MQTT broker)
- [ ] Battery health estimation model
- [ ] Web-based dashboard with historical data and alert logs
- [ ] 3D-printed T-shaped station body with solar panel mount
- [ ] Figma UI blueprint for mission control dashboard

---

## 🖥️ Dashboard Preview

> Live telemetry dashboard showing:
> - Temperature & Humidity curves
> - CO₂ level with threshold alert band
> - Ventilation status (ON/OFF)
> - Solar charge percentage
> - *(Optional)* ML anomaly prediction confidence

---

## 📁 Project Structure

```
AETHER-1/
├── firmware/
│   └── esp32_main.ino          # ESP32 sensor + MQTT code
├── simulation/
│   └── wokwi_config.json       # Wokwi simulation setup
├── dashboard/
│   ├── main.py                 # Python telemetry dashboard
│   └── streamlit_app.py        # Optional Streamlit ML dashboard
├── ml/                         # Optional ML layer
│   ├── data/                   # Logged sensor CSVs
│   ├── train.py                # Model training script
│   ├── model.tflite            # Quantized model for ESP32
│   └── inference.py            # Inference pipeline
├── cfd/
│   └── co2_stagnation_sim/     # CFD simulation files
├── docs/
│   ├── wiring_diagram.png
│   ├── figma_blueprint.png
│   └── problem_statement.md
└── README.md
```

---

##  Getting Started

### 1. Flash the ESP32
```bash
# Open firmware/esp32_main.ino in Arduino IDE
# Set your WiFi credentials and MQTT broker IP
# Flash to ESP32
```

### 2. Run the Python Dashboard
```bash
pip install -r requirements.txt
python dashboard/main.py
```

### 3. Optional — Run ML Inference
```bash
# Train model on logged data
python ml/train.py

# Run prediction dashboard
streamlit run dashboard/streamlit_app.py
```

---

##  Simulation
CFD simulation demonstrates CO₂ stagnation pocket formation in microgravity conditions — visualizing the exact problem AETHER-1 solves. Run in OpenFOAM or ANSYS Fluent.

Wokwi simulation available for hardware validation without physical components.

---

##  ML Pipeline *(Optional)*

```
Sensor Data → CSV Logger → Pandas Preprocessing
     → Feature Engineering (rolling stats, lag features)
          → LSTM / Isolation Forest
               → Anomaly Score
                    → Predictive Ventilation Trigger
```

Model is quantized to TFLite for optional onboard ESP32 inference.

---

##  Built For

**Smart India Hackathon 2024**  
Domain: Space Technology / Environmental Monitoring  
Team: [Team Name]  
College: KSIT Bangalore

---

##  Author

**Giogio**  
Mechanical Engineering — KSIT Bangalore  
Data & Telemetry Lead — Team Redline Racing (BAJA SAE)  
[GitHub](https://github.com/) • [LinkedIn](https://linkedin.com/)

---

##  License

MIT License — open for extension and research use.
