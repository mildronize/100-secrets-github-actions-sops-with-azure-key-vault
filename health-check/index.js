#!node
const axios = require("axios").default;
const fs = require("fs");
const path = require("path");
const { promisify } = require("util");
const util = require('util');
const readFile = promisify(fs.readFile);

const defaultUnicode = "utf8";

const jsonPath = process.argv[2];

const delay = (ms) => new Promise((resolve) => setTimeout(() => resolve(), ms));

async function main() {
  const data = JSON.parse(
    await readFile(path.resolve(jsonPath), defaultUnicode)
  );
  const appNames = data.map((item) => item.name);
  console.log(appNames);

  while (true) {
    console.clear()
    for (let i = 0; i < appNames.length; i++) {
        checkHealth(appNames[i], `https://${appNames[i]}.azurewebsites.net`);
    }
    await
    await delay(3000);
  }
}

// Want to use async/await? Add the `async` keyword to your outer function/method.
async function checkHealth(name, url) {
  try {
    const response = await axios.get(url, { timeout: 1000 });
    console.log(`✅ ${name} = ${response.data}`);
  } catch (error) {
    console.log(`❌ ${name}`);
  }
}

main();
