import socket from "./../game_socket.js"
import gameUtils from "./utils.js"

// players
let players = {}
let player = gameUtils.playerFactory()

// Now that you are connected, you can join channels with a topic.
// Let's assume you have a channel with a topic named `room` and the
// subtopic is its id - in this case 42:
let channel = socket.channel("game:lobby", {player: player})

channel.on("update_players", payload => {
  players = payload
  update_game_arena()
})

channel.join()
  .receive("ok", resp => {
    console.log("Joined successfully", resp)
    players = resp
  })
  .receive("error", resp => { console.log("Unable to join", resp) })

// Game canvas
let game_canvas = document.getElementById("bombermonster_canvas")
let context = game_canvas.getContext("2d")

const create_players = (players) => {
  for(let player_id in players) {
    let player = players[player_id]
    context.fillStyle = player.color
    context.fillRect(player.x, player.y, 30, 30)
  }
}

const update_game_arena = () => {
  context.clearRect(0, 0, game_canvas.width, game_canvas.height)
  create_players(players)

  requestAnimationFrame(update_game_arena)
}

window.onkeydown = function(event) {
  event.preventDefault()

  switch(event.keyCode) {
    case 40:
      player.y += 10
      break
    case 38:
      player.y -= 10
      break
    case 39:
      player.x += 10
      break
    case 37:
      player.x -= 10
      break
  }

  channel.push("move", player)
}

requestAnimationFrame(update_game_arena)
