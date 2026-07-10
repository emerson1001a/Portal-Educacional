import fs from "node:fs";

const files = ["index.html", "child.html", "entrar.html"].filter((file) => fs.existsSync(file));
let totalScripts = 0;

for (const file of files) {
  const html = fs.readFileSync(file, "utf8");
  const scripts = [...html.matchAll(/<script>([\s\S]*?)<\/script>/g)];
  scripts.forEach((script) => new Function(script[1]));
  totalScripts += scripts.length;
}

console.log(`inline script ok: ${totalScripts}`);
