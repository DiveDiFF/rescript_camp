let input = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day6.sample.txt")

let inputList =
  input
  ->Js.String2.split("\n\n")
  ->Belt.Array.map(group => Js.String2.split(group, "\n"))
  ->Belt.Array.map(group => group->Belt.Array.map(answers => answers->Js.String2.split("")))
  ->Belt.Array.map(group => Belt.Array.concatMany(group))

inputList
->Belt.Array.map(group => Belt.Set.String.fromArray(group)->Belt.Set.String.toArray)
->Belt.Array.reduce(0, (acc, value) => acc + Belt.Array.length(value))
->Js.log
