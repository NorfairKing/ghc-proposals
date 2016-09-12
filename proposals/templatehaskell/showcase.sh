note () {
  echo "$@"
}

space () {
  echo
}

bigspace () {
  space
  space
}

showCmd () {
    things="$@"
    echo "$ $things"
    $things
}

code () {
  echo '```'
}

showOffCmd () {
    code
    showCmd $@
    code
}

modsCmd="find . -mmin 1 -type f"
realModsCmd="$modsCmd ! -name showcase.sh"
mods () {
  $realModsCmd
}

showMods () {
  echo "$ $modsCmd # Find the files that were modified"
  $realModsCmd
}

reset () {
  find . -type f ! -name showcase.sh -exec touch -r {} -d '+5 min' {} \;
}

showFile () {
  code
  showCmd "cat $@"
  code
}

createFile () {
  name="$1"
  contents="$2"
  echo -e "$contents" > "$name"
  showFile $name
}

title () {
  echo "# $@"
}

subtitle () {
  echo "## $@"
}

preface () {
  title 'Template Haskell Recompilation'
  note 'This is a document that outlines the problem with GHCs recompilation strategy'
  note 'when `{-# LANGUAGE TemplateHaskell #-}` is involved'
}

recompile () {
  showCmd ghc --make Main.hs
}

createRegularSources () {
  note "First we will create some regular Haskell sources to show how the recompilation process usually works:"
  bigspace
  createFile "T.hs"    "module T where\ndata A = A\ndata B = B\n  deriving Show"
  space
  createFile "A.hs"    "module A where\nimport T\nf :: A\nf = A"
  space
  createFile "B.hs"    "module B where\nimport T\nimport A\ng :: A -> B\ng A = B"
  space
  createFile "Main.hs" "module Main where\nimport A\nimport B\nmain :: IO ()\nmain = print $ g f"
  reset
  note "The dependency graph is relatively simple:"
  code
  note "Main --- > A --> T"
  note "  \\       ^     ^"
  note "   -> B _/______/"
  code
}

compileForTheFirstTime () {
  bigspace
  note 'When we compile `Main.hs` for the first time, all four modules get compiled:'
  code
  recompile
  code 
  note 'We see that all the files were modified.'
  code 
  showMods
  code 
  reset
}

modifyWithout () {
  note 'If we now modify B to add a new function `h`:'
  echo -e "h :: B\nh = B" >> "B.hs"
  showFile "B.hs"

  note "... nothing needs to be recompiled:"
  code
  recompile
  showMods
  code 
  reset
}

preface

subtitle "Without TemplateHaskell"
createRegularSources
compileForTheFirstTime
modifyWithout




