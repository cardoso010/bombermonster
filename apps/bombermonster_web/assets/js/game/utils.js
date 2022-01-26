const getColor = () => {
  let colors = ["red", "black", "blue", "yellow", "green", "gray", "pink"]
  return colors[Math.floor(Math.random() * 6)]
}

const getId = () => {
  return Math.floor(Math.random() * 1000000000)
}

export default {
  getColor,
  getId
}
