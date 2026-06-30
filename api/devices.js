export default function handler(req, res) {
  res.status(200).json({
    data: [
      { device_name: "LED1", device_type: "LED", status: "OFF" },
      { device_name: "LED2", device_type: "LED", status: "ON" },
      { device_name: "TEMP", device_type: "SENSOR", status: "ACTIVE" }
    ]
  });
}