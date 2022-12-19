let input = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day2.sample.txt")

let inputList =
  input
  ->Js.String2.split("\n")
  ->Belt.Array.map(item => Js.String2.split(item, " "))
  ->Belt.Array.map(item => {
    let conditionArray =
      Js.String2.split(item[0], "-")->Belt.Array.map(value =>
        Belt.Int.fromString(value)->Belt.Option.getWithDefault(0)
      )
    ((conditionArray[0], conditionArray[1]), item[1]->Js.String2.charAt(0), item[2])
  })

inputList
->Belt.Array.keep(item => {
  let (condition, char, password) = item
  let (min, max) = condition
  let numberOfChar = Js.String2.split(password, char)->Belt.Array.length - 1
  min <= numberOfChar && max >= numberOfChar
})
->Belt.Array.length
->Js.log
