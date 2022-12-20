let input = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day4.sample.txt")

type passportKeyType = Byr | Iyr | Eyr | Hgt | Hcl | Ecl | Pid | Cid

type passportType = {passportKeyType: string}

let inputList =
  input
  ->Js.String2.split("\n\n")
  ->Belt.Array.map(passport => {
    passport
    ->Js.String2.split("\n")
    ->Belt.Array.map(item => item->Js.String2.split(" "))
    ->Belt.Array.concatMany
    ->Belt.Array.keepMap(item =>
      switch item->Js.String2.split(":") {
      | [key, value] =>
        Some(
          switch key {
          | "byr" => Byr
          | "iyr" => Iyr
          | "eyr" => Eyr
          | "hgt" => Hgt
          | "hcl" => Hcl
          | "ecl" => Ecl
          | "pid" => Pid
          | "cid" => Cid
          | _ => Js.Exn.raiseError(`error`)
          },
          value,
        )
      | _ => None
      }
    )
  })

let validKeys = [Byr, Iyr, Eyr, Hgt, Hcl, Ecl, Pid]

inputList
->Belt.Array.map(item => {
  item->Js.log
  item->Belt.Array.map(((key, _)) => key)
})
->Belt.Array.keep(keyArray => {
  validKeys->Belt.Array.every(item => {
    keyArray->Js.Array2.includes(item)
  })
})
->Belt.Array.length
->Js.log
