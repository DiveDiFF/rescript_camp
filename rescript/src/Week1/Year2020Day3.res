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

let getNumberOfTree = (roadMap, right, down) => {
  let end = roadMap->Js.Array2.length - 1

  let path = ref([])

  let rec getPosition = (x: int, y: int) => {
    if y <= end {
      let newRight = mod(x + right, roadMap[y]->Js.String2.length)
      getPosition(newRight, y + down)
      path.contents->Belt.Array.push(Js.String2.charAt(roadMap[y], newRight))
    }
  }
  getPosition(0, down)
  path.contents->Js.Array2.filter(item => item === "#")->Js.Array2.length
}

getNumberOfTree(roadMap, 3, 1)->Js.log
