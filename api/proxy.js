export default async function handler(req,res){

const response = await fetch("http://tc.sbtc-mng.com/api.php", {
method: req.method,
headers: { "Content-Type": "application/json" },
body: req.method !== "GET" ? JSON.stringify(req.body) : undefined
});

const data = await response.json();

res.status(200).json(data);
}
