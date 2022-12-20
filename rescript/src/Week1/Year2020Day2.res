let input = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day2.sample.txt")

// let inputList =
//   input
//   ->Js.String2.split("\n")
//   ->Belt.Array.map(item => Js.String2.split(item, " "))
//   ->Belt.Array.map(item => {
//     let conditionArray =
//       Js.String2.split(item[0], "-")->Belt.Array.map(value =>
//         Belt.Int.fromString(value)->Belt.Option.getWithDefault(0)
//       )
//     ((conditionArray[0], conditionArray[1]), item[1]->Js.String2.charAt(0), item[2])
//   })

let inputList =
  input
  ->Js.String2.split("\n")
  ->Belt.Array.map(item => {
    switch item->Js.String2.split(" ") {
    | [period, pattern, password] =>
      switch period->Js.String2.split("-")->Belt.Array.map(Belt.Int.fromString) {
      | [Some(first), Some(second)] => ((first, second), pattern->Js.String2.charAt(0), password)
      | _ => Js.Exn.raiseError(`can not find first, second int in period`)
      }
    | _ => Js.Exn.raiseError(`can not match length of this array`)
    }
  })

inputList->Js.log

// part1
inputList
->Belt.Array.keep((((first, second), pattern, password)) => {
  let numberOfChar = Js.String2.split(password, pattern)->Belt.Array.length - 1
  first <= numberOfChar && second >= numberOfChar
})
->Belt.Array.length
->Js.log

// part2
inputList
->Belt.Array.keep((((first, second), pattern, password)) => {
  let firstMatch = Js.String2.charAt(password, first - 1) === pattern
  let secondMatch = Js.String2.charAt(password, second - 1) === pattern

  switch (firstMatch, secondMatch) {
  | (true, true) => false
  | (true, false) => true
  | (false, true) => true
  | (false, false) => false
  }
})
->Belt.Array.length
->Js.log
