#!/bin/bash

_m2_make_goals()
{
  plugin=$1
  mojos=$2
  for mojo in $mojos
  do
    export goals="$goals $plugin:$mojo"
  done
}

_m2_complete()
{
  local cur goals

  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}
  goals='clean compile test install package deploy site generate-sources'
  goals=$goals _m2_make_goals "eclipse" "eclipse"
  goals=$goals _m2_make_goals "idea" "idea"
  goals=$goals _m2_make_goals "assembly" "assembly"
  goals=$goals _m2_make_goals "jar" "jar"
  goals=$goals _m2_make_goals "cobertura" "cobertura clean"
  goals=$goals _m2_make_goals "javadoc" "javadoc"
  goals=$goals _m2_make_goals "plexus" "app bundle-application bundle-runtime descriptor runtime service"
  goals=$goals _m2_make_goals "clojure" "compile test run repl swank nailgun"
  goals=$goals _m2_make_goals "dependency" "tree build-classpath"

  cur=`echo $cur | sed 's/\\\\//g'`
  COMPREPLY=($(compgen -W "${goals}" ${cur} | sed 's/\\\\//g') )
}

complete -F _m2_complete -o filenames mvn

