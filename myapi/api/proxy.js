async function handler(req, res) {
  try {
    const targetUrl = process.env.TARGET_API_URL || "https://tc.sbtc-mng.com/api.php";
    const method = req.method || "GET";
    const headers = {
      Accept: "application/json"
    };

    const requestUrl = new URL(req.url || "/", "https://" + (req.headers.host || "localhost"));
    const target = new URL(targetUrl);
    target.search = requestUrl.search;

    let body;
    if (method !== "GET" && method !== "HEAD") {
      if (req.body && typeof req.body === "string") {
        body = req.body;
      } else if (req.body && typeof req.body === "object") {
        body = JSON.stringify(req.body);
      }

      headers["Content-Type"] = "application/json";
    }

    const response = await fetch(target.toString(), {
      method,
      headers,
      body
    });

    const text = await response.text();
    let parsed = {};

    try {
      parsed = text ? JSON.parse(text) : {};
    } catch {
      parsed = { success: false, message: text };
    }

    const normalized = parsed && Object.prototype.hasOwnProperty.call(parsed, "data")
      ? parsed
      : { success: true, message: "ok", data: parsed };

    res.status(response.status).json(normalized);
  } catch (err) {
    res.status(500).json({
      success: false,
      message: "Proxy Error",
      error: err.toString()
    });
  }
}

module.exports = handler;