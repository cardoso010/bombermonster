// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// Bring in Phoenix channels client library:
import {Socket} from "phoenix"
import gameUtils from "./game/utils.js"
// And connect to the path in "lib/bombermonster_web/endpoint.ex". We pass the
// token for authentication. Read below how it should be used.
let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/bombermonster_web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/bombermonster_web/templates/layout/app.html.heex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/3" function
// in "lib/bombermonster_web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket, _connect_info) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1_209_600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, connect to the socket:
socket.connect()

// player
let player = {id: gameUtils.getId(), x: 10, y: 10, color: gameUtils.getColor()}
let players = {}

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

const create_rect = (players) => {
  for(let player_id in players) {
    let player = players[player_id]
    context.fillStyle = player.color
    context.fillRect(player.x, player.y, 30, 30)
  }
}

const update_game_arena = () => {
  context.clearRect(0, 0, game_canvas.width, game_canvas.height)
  create_rect(players)

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

export default socket
