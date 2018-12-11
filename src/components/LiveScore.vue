
<template>
<div align="center">
<form
  align="left"
  id="app"
  novalidate="true"
>
    <h1>
      Messi
      <small class="text-muted">by Kresna Jenie</small>
    </h1>
    <label>Pertandingan</label>
    <v-select
        id="pertandingan"
        v-model="selected_match" :options="matchDisplay"
        type="text"
        name="pertandingan"
        @selected="matchSelected()"
    ></v-select>
    <div v-show="tampil">
      <table class="table">
          <thead class="thead-dark">
          <tr align="center">
              <th>{{ homeTeam }}</th>
              <th>vs</th>
              <th>{{ awayTeam }}</th>
          </tr>
          </thead>
          <tr align="center">
              <td><h1>{{ homeScore }}</h1></td>
              <td><h1 style="color:red">{{ half }}</h1></td>
              <td><h1>{{ awayScore }}</h1></td>
          </tr>
          <tr align="center">
              <td>
                  <b-btn variant="danger" @click="substractHomeScore">kurang</b-btn>
                  <b-btn variant="success" @click="addHomeScore">tambah</b-btn>
              </td>
              <td>
                <b-button-group>
                  <b-button @click="firstHalf" variant="primary">1st</b-button>
                  <b-button @click="secondHalf" variant="primary">2nd</b-button>
                </b-button-group>
              </td>
              <td>
                  <b-btn variant="danger" @click="substractAwayScore">kurang</b-btn>
                  <b-btn variant="success" @click="addAwayScore">tambah</b-btn>
              </td>
          </tr>
      </table>
    </div>
  <footer >

  <!-- Copyright -->
  <div class="footer-copyright text-center py-3">© Copyright 2018, Kresna Jenie. All Rights Reserved
  </div>
  <!-- Copyright -->

</footer>

</form>
</div>
</template>

<script>
import vSelect from 'vue-select'
import api from '@/api'
import io from 'socket.io-client'

export default{
  watch: {
    selected_match: function (matchSchool) {
      // console.log(matchSchool)
      var indexSchool = this.matchDisplay.indexOf(matchSchool)
      // console.log(indexSchool)
      var matchID = this.matchValue[indexSchool]
      this.selected_match_id = matchID
      this.searchMatch(matchID)
    },
    match: function (matchDict) {
      this.tampil = true
      this.homeTeam = matchDict.home_team
      this.awayTeam = matchDict.away_team
      this.homeScore = parseInt(matchDict.home_score)
      this.awayScore = parseInt(matchDict.away_score)
      this.half = matchDict.half
    }
  },
  components: {
    'v-select': vSelect
  },
  beforeUpdate () {
    this.checkScore()
  },
  created () {
    this.refreshMatches()
    // // console.log('test')
    // // console.log(this.matches)
  },
  mounted () {
    this.socket.on('match_id', (data) => {
      console.log(data)
      // you can also do this.messages.push(data)
    })
    this.refreshMatches()
  },
  data () {
    return {
      tampil: false,
      half: '1st',
      homeTeam: '',
      awayTeam: '',
      homeScore: 0,
      awayScore: 0,
      matches: [],
      selected_match: '',
      selected_match_id: '',
      match: {},
      matchDisplay: [],
      matchValue: [],
      // socket: io('localhost:3001')
      socket: io('https://socket.jaskapital.com')
    }
  },
  methods: {
    sendMessage (e) {
      console.log('send socket')
      this.socket.emit('MATCH_ID', this.match)
      this.message = ''
    },
    matchSelected: function () {
      // // console.log('clickedd')
      // console.log(this.selected_match)
    },
    addHomeScore: function () {
      this.homeScore = this.homeScore + 1
      this.match.home_score = this.homeScore
      this.saveMatch()
    },
    substractHomeScore: function () {
      this.homeScore = this.homeScore - 1
      this.match.home_score = this.homeScore
      this.saveMatch()
    },
    addAwayScore: function () {
      this.awayScore = this.awayScore + 1
      this.match.away_score = this.awayScore
      this.saveMatch()
    },
    substractAwayScore: function () {
      this.awayScore = this.awayScore - 1
      this.match.away_score = this.awayScore
      this.saveMatch()
    },
    checkScore: function () {
      if (this.homeScore < 0) {
        this.homeScore = 0
      };
      if (this.awayScore < 0) {
        this.awayScore = 0
      }
    },
    firstHalf: function () {
      this.half = '1st'
      this.match.half = this.half
      this.saveMatch()
    },
    secondHalf: function () {
      this.half = '2nd'
      this.match.half = this.half
      this.saveMatch()
    },
    async saveMatch () {
      await api.updateMatch(this.match.id, this.match)
      this.sendMessage()
      // // console.log('saved')
    },
    async refreshMatches () {
      this.matches = await api.getMatches()
      // // console.log('test2')
      for (var index = 0; index < this.matches.length; ++index) {
        // // console.log(this.matches[index])
        var display = this.matches[index].home_team + '  vs  ' + this.matches[index].away_team
        var value = this.matches[index].match_id
        this.matchDisplay.push(display)
        this.matchValue.push(value)
      }
      // // console.log(this.matchIDS)
      // console.log(this.matchDisplay)
      // console.log(this.matchValue)
    },
    async searchMatch (matchID) {
      this.matches = await api.searchMatch(matchID)
      this.match = this.matches[0]
      this.sendMessage()
      // console.log(this.match)
    }
  }
}
</script>

<style>
  input[type=text], select {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}
  input[type=email], select {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}
  input[type=number], select {
    width: 10%;
    padding: 12px 20px;
    margin: 8px 10px;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

input[type=start] {
    width: 100%;
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

input[type=start]:hover {
    background-color: #45a049;
}
form {
    width: 50%;
    border-radius: 5px;
    background-color: #f2f2f2;
    padding: 20px;
}
</style>
