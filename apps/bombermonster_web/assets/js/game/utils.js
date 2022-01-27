const getColor = () => {
  let colors = ["red", "black", "blue", "yellow", "green", "gray", "pink"]
  return colors[Math.floor(Math.random() * 6)]
}

const getId = () => {
  return Math.floor(Math.random() * 1000000000)
}

const getPosition = () => {
  return Math.floor(Math.random() * 100)
}

const playerFactory = () => {
  return {id: getId(), x: getPosition(), y: getPosition(), color: getColor()}
}

export default {
  getColor,
  getId,
  playerFactory
}
