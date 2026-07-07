import fs from "node:fs";

const html = fs.readFileSync("index.html", "utf8");
const scripts = [...html.matchAll(/<script>([\s\S]*?)<\/script>/g)];

for (const script of scripts) {
  new Function(script[1]);
}

console.log(`inline script ok: ${scripts.length}`);
