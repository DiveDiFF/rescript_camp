let input = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day5.sample.txt")

let inputList = Js.String2.split(input, "\n")

type seatCalculateType = Up | Down

let maxSeatVertical = 127
let maxSeatHorizontal = 7

let getSeatId = (seats: array<seatCalculateType>, maxId) => {
  let (min, max) = seats->Belt.Array.reduce((0, maxId), ((min, max), seat) => {
    switch seat {
    | Down => (min, (min + max) / 2)

    | Up => ((min + max) / 2 + 1, max)
    }
  })
  if min != max {
    Js.Exn.raiseError(`min, max is not equal`)
  }
  max
}

let parser = seat => {
  let verticalId =
    seat
    ->Js.String2.substring(~from=0, ~to_=7)
    ->Js.String2.split("")
    ->Belt.Array.map(char =>
      switch char {
      | "F" => Down
      | "B" => Up
      | _ => Js.Exn.raiseError(`${char} is not valid character`)
      }
    )
    ->getSeatId(maxSeatVertical)

  let horizontalId =
    seat
    ->Js.String2.substring(~from=7, ~to_=10)
    ->Js.String2.split("")
    ->Belt.Array.map(char =>
      switch char {
      | "L" => Down
      | "R" => Up
      | _ => Js.Exn.raiseError(`${char} is not valid character`)
      }
    )
    ->getSeatId(maxSeatHorizontal)

  8 * verticalId + horizontalId
}

inputList
->Belt.Array.map(item => {
  parser(item)
})
->Js.Array2.sortInPlaceWith((a, b) => b - a)
->Js.Array2.shift
->Js.log

// // !take1
// let parseCharacter = char => {
//   switch char {
//   | "F" => Front
//   | "B" => Back
//   | "L" => Left
//   | "R" => Right
//   | _ => Js.Exn.raiseError(`${char} is not valid character`)
//   }
// }

// let getPosition = ((vertical, horizontal), seatType) => {
//   switch seatType {
//   | Front => (
//       vertical->Belt.Array.keepWithIndex((_, index) => index < Belt.Array.length(vertical) / 2),
//       horizontal,
//     )

//   | Back => (
//       vertical->Belt.Array.keepWithIndex((_, index) => index >= Belt.Array.length(vertical) / 2),
//       horizontal,
//     )

//   | Left => (
//       vertical->Belt.Array.keepWithIndex((_, index) => index >= Belt.Array.length(vertical) / 2),
//       horizontal,
//     )

//   | Right => (
//       vertical,
//       horizontal->Belt.Array.keepWithIndex((_, index) =>
//         index >= Belt.Array.length(horizontal) / 2
//       ),
//     )
//   }
// }

// inputList
// ->Belt.Array.map(passcode => {
//   passcode
//   ->Js.String2.split("")
//   ->Belt.Array.reduceWithIndex((Belt.Array.range(0, 127), Belt.Array.range(0, 7)), (
//     acc,
//     value,
//     index,
//   ) => {
//     // (acc, value, index)->Js.log
//     getPosition(acc, value->parseCharacter)
//   })
// })
// ->Js.log
