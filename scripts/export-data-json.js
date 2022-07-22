#!/usr/bin/env node --experimental-fetch

const { writeFileSync } = require('fs')

const TOKEN_ID_INDEX = 0
const NAME_INDEX = 2
const DESCRIPTION_INDEX = 5
const IMAGE_URL_INDEX = 6
const GENERATION_INDEX = 7
const ALGO_INDEX = 8
const BIRTHDAY_INDEX = 11
const EXTERNAL_URL_INDEX = 12

const writeDataFiles = (rows) => {
  for (var i = 1; i < rows.length; i++) {
    const datum = {
      name: rows[i][NAME_INDEX],
      description: rows[i][DESCRIPTION_INDEX],
      image: rows[i][IMAGE_URL_INDEX],
      external_url: rows[i][EXTERNAL_URL_INDEX],
      attributes: [
        { trait_type: 'Generation', value: parseInt(rows[i][GENERATION_INDEX]) },
        { trait_type: 'Algo', value: rows[i][ALGO_INDEX] },
        { trait_type: 'Birthday', display_type: 'date', value: parseInt(rows[i][BIRTHDAY_INDEX]) },
        { trait_type: 'Last Updated', display_type: 'date', value: ~~(Date.now() / 1000) },
      ],
    }

    const fileName = `docs/data/${rows[i][TOKEN_ID_INDEX]}.json`

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

    console.log('Done.')
  })
