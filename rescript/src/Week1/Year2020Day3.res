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

let input = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day3.sample.txt")

let roadMap = Js.String2.split(input, "\n")

type slopeRecord = {
  right: int,
  down: int,
}

let getNumberOfTree = (roadMap, slope: slopeRecord) => {
  let end = roadMap->Js.Array2.length - 1

  let path = ref([])

  let rec getPosition = (x: int, y: int) => {
    switch y <= end {
    | true => {
        let newRight = mod(x + slope.right, roadMap[y]->Js.String2.length)
        getPosition(newRight, y + slope.down)
        path.contents->Belt.Array.push(Js.String2.charAt(roadMap[y], newRight))
      }

    | false => ()
    }
  }
  getPosition(0, slope.down)
  path.contents->Js.Array2.filter(item => item === "#")->Js.Array2.length
}

let resultList = [
  getNumberOfTree(roadMap, {right: 1, down: 1}),
  getNumberOfTree(roadMap, {right: 3, down: 1}),
  getNumberOfTree(roadMap, {right: 5, down: 1}),
  getNumberOfTree(roadMap, {right: 7, down: 1}),
  getNumberOfTree(roadMap, {right: 1, down: 2}),
]

Belt.Array.reduce(resultList, 1.0, (acc, currentVal) => acc *. Js.Int.toFloat(currentVal))->Js.log
