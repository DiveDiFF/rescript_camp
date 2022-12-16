let input = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day6.sample.txt")

let inputList =
  input
  ->Js.String2.split("\n\n")
  ->Belt.Array.map(group => Js.String2.split(group, "\n"))
  ->Belt.Array.map(group => group->Belt.Array.map(answers => answers->Js.String2.split("")))

let getSumAnswers = answerSheetGroup => {
  answerSheetGroup->Belt.Array.reduce(0, (acc, value) => acc + Belt.Array.length(value))
}

// part1
inputList
->Belt.Array.map(group => Belt.Array.concatMany(group))
->Belt.Array.map(group => Belt.Set.String.fromArray(group)->Belt.Set.String.toArray)
->getSumAnswers
->Js.log

// part2
let getEveryoneAnsweredYes = (answerSheet: array<string>, entireCount: int) => {
  let map = Belt.Map.String.empty
  answerSheet
  ->Belt.Array.reduce(map, (acc, value) => {
    Belt.Map.String.set(
      acc,
      value,
      switch Belt.Map.String.get(acc, value) {
      | None => 0
      | Some(v) => v
      } + 1,
    )
  })
  ->Belt.Map.String.keep((_, value) => value == entireCount)
  ->Belt.Map.String.keysToArray
}

inputList
->Belt.Array.map(group => {
  (Belt.Array.length(group), Belt.Array.concatMany(group))
})
->Belt.Array.map(((key, value)) => {
  value->getEveryoneAnsweredYes(key)
})
->getSumAnswers
->Js.log
