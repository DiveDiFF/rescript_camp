let input = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day3.sample.txt")

let roadMap = Js.String2.split(input, "\n")

let numberOfTree = ref(0)

let rec getPosition = (x: int, y: int) => {
  let end = roadMap->Js.Array2.length - 1
  if y <= end {
    getPosition(x + 3, y + 1)
    if Js.String2.charAt(roadMap[y], mod(x, roadMap[y]->Js.String2.length)) === "#" {
      numberOfTree := numberOfTree.contents + 1
    }
  }
}

getPosition(0, 0)

numberOfTree->Js.log
