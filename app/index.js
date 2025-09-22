const express = require("express");
const app = express();
const port = process.env.PORT || 8080;
app.get("/", (_req, res) => res.send("Hello from Dockerized Node! - vNext"));
app.listen(port, "0.0.0.0", () => console.log(`Server listening on 0.0.0.0:${port}`));
