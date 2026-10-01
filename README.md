
# Project Sub-zero: Hybrid ISS-Tiangong Smart Space Station Testbed 🛰️

![ESP32](https://img.shields.io/badge/Hardware-ESP32-blue)
![C++](https://img.shields.io/badge/Firmware-C%2B%2B%20%2F%20Arduino-00599C?logo=c%2B%2B)
![Python](https://img.shields.io/badge/ML-Python%20%2F%20Random%20Forest-FFD43B?logo=python)
![Simulation](https://img.shields.io/badge/CFD-OpenFOAM%20%2F%20SimScale-red)
![Status](https://img.shields.io/badge/Status-Prototyping-orange)

**Project Sub-zero** is a physical, ML-enhanced, sensor-driven space station analog testbed. Developed as a 5th-semester mechanical engineering and Smart India Hackathon (SIH) prototype, it merges documented architectural advantages from the ISS (node-hub multi-port design) and China’s Tiangong Space Station (T-shaped layout, intermodule shadowing optimization). .

The project demonstrates a complete sense-decide-actuate control loop to solve two critical, unresolved challenges in modern space habitats: microgravity air-stagnation (CO2 pockets) and predictive solar power optimization.

---

## 🚀 Key Problem Statements & Solutions

### 1. Life Support & Microgravity Air Stagnation
*   **The Problem:** In microgravity, the lack of buoyancy-driven convection causes warm, CO2-rich air to stagnate around astronauts, leading to hypercapnia (CO2 toxicity). Current stations rely on reactive monitoring and localized fans that leave stagnant pockets.
*   **The Solution (Active ECLSS):** An integrated MQ-135 and DHT22 sensor array maps cabin air quality. The ESP32 logic detects forming CO2 pockets and autonomously actuates localized ventilation (L298N-driven DC fans) to disperse them, while triggering local OLED and buzzer alerts.

### 2. Solar Array Efficiency & Intermodule Shadowing
*   **The Problem:** Complex modular station layouts (like the T-shape) cause intermodule shadowing, heavily degrading power generation. Existing trackers react to light intensity *after* a power drop occurs.
*   **The Solution (Predictive ML Layer):** A dual-axis solar tracking system augmented with a **Random Forest regression model**. Training on timestamped local telemetry data, the ML layer anticipates efficiency drop-offs and adjusts panel angles *ahead* of the light curve.

---

## 🛠️ Tech Stack & Methodology

The project follows a **Design-First** engineering methodology:
`Circuit Simulation ➔ 3D CAD Design ➔ CFD Validation ➔ Physical Build ➔ ML Training ➔ Telemetry Dashboard`

*   **Edge Hardware:** ESP32 (38-pin DevKit)
*   **Sensors:** MQ-135 (Air Quality), DHT22 (Climate), BMP280 (Pressure/Leak Detection), HC-SR04 (Proximity/Docking), MPU6050 (IMU/Attitude), LDRs (Solar Tracking)
*   **Actuators:** SG90 Servos (Docking hatch & Solar Tracking), L298N Motor Driver + DC Fans
*   **Firmware:** C++ (Arduino Framework)
*   **Machine Learning:** Python (Scikit-Learn, Random Forest Regression)
*   **Simulation:** Wokwi (Circuit), OpenFOAM / SimScale (Zero-G vs Standard Gravity CFD Airflow Validation)

---

## 🗂️ Repository Structure

```text
├── firmware/                 # C++ ESP32 source code (Arduino IDE compatible)
│   ├── main/                 # Main control loop (Sense-Decide-Actuate)
│   └── lib/                  # Custom sensor and actuator libraries
├── machine_learning/         # Python scripts for solar tracking prediction
│   ├── dataset/              # CSV telemetry logs (timestamped via DS3231)
│   └── model_training.py     # Random Forest regression model
├── hardware/                 # Circuit schematics and pinouts
│   ├── wokwi_simulation/     # diagram.json and sketch.ino for Wokwi
│   └── schematics/           # Wiring diagrams
├── mechanical_cad/           # 3D models for T-shape PVC structure & mounts
├── cfd_simulation/           # OpenFOAM/SimScale reports (0-G vs 1-G airflow)
└── README.md
