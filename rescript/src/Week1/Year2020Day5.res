let input = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day5.sample.txt")

let inputList = Js.String2.split(input, "\n")

let getRowsPosition = (list, char) => {
  if char === "F" {
    [
      list[0]->Belt.Array.keepWithIndex((_, index) => index < Belt.Array.length(list[0]) / 2),
      list[1],
    ]
  } else if char === "B" {
    [
      list[0]->Belt.Array.keepWithIndex((_, index) => index >= Belt.Array.length(list[0]) / 2),
      list[1],
    ]
  } else if char === "L" {
    [
      list[0],
      list[1]->Belt.Array.keepWithIndex((_, index) => index < Belt.Array.length(list[1]) / 2),
    ]
  } else if char === "R" {
    [
      list[0],
      list[1]->Belt.Array.keepWithIndex((_, index) => index >= Belt.Array.length(list[1]) / 2),
    ]
  } else {
    list
  }
}

inputList
->Belt.Array.map(passcode => {
  passcode
  ->Js.String2.split("")
  ->Belt.Array.reduceWithIndex([Belt.Array.range(0, 127), Belt.Array.range(0, 7)], (
    acc,
    value,
    index,
  ) => {
    (acc, value, index)->Js.log
    getRowsPosition(acc, value)
  })
})
->Js.log

// let getRowsPosition = (rowList, char) => {
//   switch char {
//   | Some('F') => [rowList[0], rowList[1] / 2]
//   | Some('B') => [rowList[1] / 2, rowList[1]]
//   | None => rowList
//   }
// }

// let getColumnPosition = (columnList, char) => {
//   switch char {
//   | Some('L') => [columnList[0], columnList[1] / 2]
//   | Some('R') => [columnList[1] / 2, columnList[1]]
//   | None => columnList
//   }
// }

// inputList
// ->Belt.Array.map(passcode => {
//   passcode->Js.log
//   passcode
//   ->Js.String2.split("")
//   ->Belt.Array.reduce([0, 127], (acc, value) => {
//     (acc, value)->Js.log
//     if value == "F" || value == "B" {
//       getRowsPosition(acc, value)
//     } else if value == "L" || value == "R" {
//       getColumnPosition(acc, Some(value))
//     } else {
//       ()
//     }
//   })
// })
// ->Js.log
