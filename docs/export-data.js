#!/usr/bin/env node

const fs = require('fs')

const data = fs.readFileSync("./index.csv").toString().split("\n").map(e => e.trim()).map(e => e.split(',').map(e => e.trim()));

const token_id_index = 0
const name_index = 3
const desc_index = 4
const image_url_index = 5

for (var i = 1; i < data.length; i++) {
  const datum = {
    name: data[i][name_index],
    description: data[i][desc_index],
    image: data[i][image_url_index],
  }

  fs.writeFileSync(`data/${data[i][token_id_index]}.json`, JSON.stringify(datum, null, 2) + '\n')
}

