// // !take1
// let input = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day3.sample.txt")

// let roadMap = Js.String2.split(input, "\n")

// let numberOfTree = ref(0)

// let rec getPosition = (x: int, y: int) => {
//   let end = roadMap->Js.Array2.length - 1
//   if y <= end {
//     getPosition(x + 3, y + 1)
//     if Js.String2.charAt(roadMap[y], mod(x, roadMap[y]->Js.String2.length)) === "#" {
//       numberOfTree := numberOfTree.contents + 1
//     }
//   }
// }

// getPosition(0, 0)

// numberOfTree->Js.log

// // !take2
// let input = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day3.sample.txt")

// let roadMap = Js.String2.split(input, "\n")

// type slopeRecord = {
//   right: int,
//   down: int,
// }

// let getNumberOfTree = (roadMap, slope: slopeRecord) => {
//   let end = roadMap->Js.Array2.length - 1

//   let rec getPosition = (path, x: int, y: int) => {
//     switch y <= end {
//     | true => {
//         let newRight = mod(x + slope.right, roadMap[y]->Js.String2.length)
//         let newPath = path->Belt.Array.concat([Js.String2.charAt(roadMap[y], newRight)])
//         getPosition(newPath, newRight, y + slope.down)
//       }

//     | false => path
//     }
//   }

//   getPosition([], 0, slope.down)->Js.Array2.filter(item => item === "#")->Js.Array2.length
// }

// let resultList = [
//   getNumberOfTree(roadMap, {right: 1, down: 1}),
//   getNumberOfTree(roadMap, {right: 3, down: 1}),
//   getNumberOfTree(roadMap, {right: 5, down: 1}),
//   getNumberOfTree(roadMap, {right: 7, down: 1}),
//   getNumberOfTree(roadMap, {right: 1, down: 2}),
// ]

// Belt.Array.reduce(resultList, 1.0, (acc, currentVal) => acc *. Js.Int.toFloat(currentVal))->Js.log


// !take3
let input = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day3.sample.txt")

let roadMap = Js.String2.split(input, "\n")

type slopeRecord = {
  right: int,
  down: int,
}

let getNumberOfTree = (roadMap, slope) => {
  let end = roadMap->Js.Array2.length - 1

  Belt.Array.rangeBy(slope.down, end, ~step=slope.down)
  ->Belt.Array.map(y => roadMap[y])
  ->Belt.Array.mapWithIndex((index, item) =>
    Js.String2.charAt(item, mod(slope.right * (index + 1), item->Js.String2.length))
  )
  ->Js.Array2.filter(item => item === "#")
  ->Js.Array2.length
}

let resultList = [
  getNumberOfTree(roadMap, {right: 1, down: 1}),
  getNumberOfTree(roadMap, {right: 3, down: 1}),
  getNumberOfTree(roadMap, {right: 5, down: 1}),
  getNumberOfTree(roadMap, {right: 7, down: 1}),
  getNumberOfTree(roadMap, {right: 1, down: 2}),
]

Belt.Array.reduce(resultList, 1.0, (acc, currentVal) => acc *. Js.Int.toFloat(currentVal))->Js.log
