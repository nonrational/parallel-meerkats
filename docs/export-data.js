#!/usr/bin/env node --experimental-fetch

const { writeFileSync } = require('fs')

const TOKEN_ID_INDEX = 0
const NAME_INDEX = 3
const DESCRIPTION_INDEX = 4
const IMAGE_URL_INDEX = 5

const writeDataFiles = (rows) => {
  console.log(rows)

  for (var i = 1; i < rows.length; i++) {
    const datum = {
      name: rows[i][NAME_INDEX],
      description: rows[i][DESCRIPTION_INDEX],
      image: rows[i][IMAGE_URL_INDEX],
    }

    const fileName = `data/${rows[i][TOKEN_ID_INDEX]}.json`

    console.log(fileName)
    writeFileSync(fileName, JSON.stringify(datum, null, 2) + '\n')
  }
}

fetch('https://docs.google.com/spreadsheets/d/e/2PACX-1vQmJKwu96Fk3AlCa7heA4rsqjtlEv-UOkYyl8xdIX0_PqnmKmOlwzucUkoPUY7My4Y7v0-AY8gdjW-o/pub?gid=0&single=true&output=csv')
  .then((response) => response.text())
  .then((body) => {
    const data = body
      .toString()
      .split('\n')
      .map((e) => e.trim())
      .map((e) => e.split(',').map((e) => e.trim()))

    writeDataFiles(data)
  })
