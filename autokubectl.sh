#!/bin/bash
#
# TODO: handle already existing command_not_found_handle function
#
# Inspired by:
# - https://github.com/ahmetb/kubectl-aliases
# - https://fedoraproject.org/wiki/Features/PackageKitCommandNotFound
#

## Verbs

declare -A autokube_command_not_found_handle_map_verb
#5
autokube_command_not_found_handle_map_verb[dbgno]='debug -it --image=alpine node/%s -- chroot /host'
autokube_command_not_found_handle_map_verb[help]='--help'
#4
autokube_command_not_found_handle_map_verb[gnok]='get node -L=kubernetes.io/arch,eks.amazonaws.com/capacityType,karpenter.sh/capacity-type,karpenter.k8s.aws/instance-cpu,karpenter.k8s.aws/instance-memory' #AWS
autokube_command_not_found_handle_map_verb[gnoz]='get node -L=kubernetes.io/arch,beta.kubernetes.io/instance-type' #Azure

#3
autokube_command_not_found_handle_map_verb[dbg]='debug -it %s'
autokube_command_not_found_handle_map_verb[lof]='logs -f'
autokube_command_not_found_handle_map_verb[run]='run --image="%s"'
#2
autokube_command_not_found_handle_map_verb[ex]='exec -i -t'
autokube_command_not_found_handle_map_verb[Ki]='krew install "%s"'    ## each "%s" is replaced with positional parameters afther the command, like in $1 $2 $N...
autokube_command_not_found_handle_map_verb[lo]='logs'
autokube_command_not_found_handle_map_verb[rm]='delete'
autokube_command_not_found_handle_map_verb[sh]='exec -i -t "%s" -- sh -i -c "bash -i || exec sh -i"'
#1
autokube_command_not_found_handle_map_verb[a]='apply'
autokube_command_not_found_handle_map_verb[c]='create'
autokube_command_not_found_handle_map_verb[d]='describe'
autokube_command_not_found_handle_map_verb[F]='FLUSH'
autokube_command_not_found_handle_map_verb[g]='get'
autokube_command_not_found_handle_map_verb[H]='HELP'
autokube_command_not_found_handle_map_verb[K]='krew'

## Resources

declare -A autokube_command_not_found_handle_map_res
#3
autokube_command_not_found_handle_map_res[crb]='clusterrolebinding'
autokube_command_not_found_handle_map_res[dep]='deployment'
autokube_command_not_found_handle_map_res[ing]='ingress'
autokube_command_not_found_handle_map_res[pvc]='pvc'
autokube_command_not_found_handle_map_res[sec]='secret'
autokube_command_not_found_handle_map_res[sts]='statefulset'
autokube_command_not_found_handle_map_res[svc]='service'
#2
autokube_command_not_found_handle_map_res[cm]='configmap'
autokube_command_not_found_handle_map_res[cr]='clusterrole'
autokube_command_not_found_handle_map_res[dc]='deploymentconfig'
autokube_command_not_found_handle_map_res[ev]='event'
autokube_command_not_found_handle_map_res[is]='imagestream'
autokube_command_not_found_handle_map_res[no]='node'
autokube_command_not_found_handle_map_res[po]='pod'
autokube_command_not_found_handle_map_res[pv]='pv'
autokube_command_not_found_handle_map_res[rb]='rolebinding'
autokube_command_not_found_handle_map_res[ro]='route'
autokube_command_not_found_handle_map_res[sa]='serviceaccount'
#1
autokube_command_not_found_handle_map_res[r]='role'

## Options

declare -A autokube_command_not_found_handle_map_opt
#7
autokube_command_not_found_handle_map_opt[ojsonpath]='-o=jsonpath="%s"'
autokube_command_not_found_handle_map_opt[otemplate]='-o=template="%s"'
#5
autokube_command_not_found_handle_map_opt[force]='--force'
autokube_command_not_found_handle_map_opt[ojson]='-o=json'
autokube_command_not_found_handle_map_opt[oname]='-o=name'
autokube_command_not_found_handle_map_opt[owide]='-o=wide'
autokube_command_not_found_handle_map_opt[oyaml]='-o=yaml'
#4
autokube_command_not_found_handle_map_opt[dryc]='--dry-run=client -o yaml'
autokube_command_not_found_handle_map_opt[dryn]='--dry-run=none -o yaml'
autokube_command_not_found_handle_map_opt[drys]='--dry-run=server -o yaml'
autokube_command_not_found_handle_map_opt[otpl]='-o=template="%s"'
autokube_command_not_found_handle_map_opt[oyml]='-o=yaml'
#3
autokube_command_not_found_handle_map_opt[all]='--all'
autokube_command_not_found_handle_map_opt[dry]='--dry-run=none -o yaml'
autokube_command_not_found_handle_map_opt[now]='--now'
autokube_command_not_found_handle_map_opt[ojp]='-o=jsonpath'
autokube_command_not_found_handle_map_opt[ojs]='-o=json'
autokube_command_not_found_handle_map_opt[sys]='-n=kube-system'
#2
autokube_command_not_found_handle_map_opt[it]='-i -t'
autokube_command_not_found_handle_map_opt[nh]='--no-headers'
autokube_command_not_found_handle_map_opt[oj]='-o=json'
autokube_command_not_found_handle_map_opt[on]='-o=name'
autokube_command_not_found_handle_map_opt[ow]='-o=wide'
autokube_command_not_found_handle_map_opt[oy]='-o=yaml'
autokube_command_not_found_handle_map_opt[rm]='--rm'
autokube_command_not_found_handle_map_opt[sb]='--sort-by="%s"'
autokube_command_not_found_handle_map_opt[sl]='--show-labels'
#1
autokube_command_not_found_handle_map_opt[A]='--all-namespaces'
autokube_command_not_found_handle_map_opt[f]='-f "%s"'
autokube_command_not_found_handle_map_opt[l]='-l "%s"'
autokube_command_not_found_handle_map_opt[L]='-L "%s"'
autokube_command_not_found_handle_map_opt[n]='-n="%s"'
autokube_command_not_found_handle_map_opt[o]='-o="%s"'
autokube_command_not_found_handle_map_opt[v]='-v="%s"'
autokube_command_not_found_handle_map_opt[w]='-w'

## watch

declare -A autokube_command_not_found_handle_map_watch
autokube_command_not_found_handle_map_watch[W]='watch -n %i --'

function autokubectl()
{
  local c="$1"
  shift

  if [ "$c" == FLUSH ]; then
    echo Flushing tables
    unset autokube_command_not_found_handle_map_verb
    unset autokube_command_not_found_handle_map_res
    unset autokube_command_not_found_handle_map_opt
    unset autokube_command_not_found_handle_map_watch
    return
  fi

  if [ "$c" == HELP ]; then
    type tabulate &>/dev/null && local tab="tabulate --sep \| -f plain" || local tab=cat

    echo Available mnemonics
    echo

    if [ -z "$1" ] || [ "${1:0:1}" == v ]; then
      echo Verbs
      echo -----
      for i in $(printf "%s\n" ${!autokube_command_not_found_handle_map_verb[*]} | sort); do
        echo "  $i:|${autokube_command_not_found_handle_map_verb[$i]}"
      done | $tab
      echo
    fi

    if [ -z "$1" ] || [ "${1:0:1}" == r ]; then
      echo Resources
      echo ---------
      for i in $(printf "%s\n" ${!autokube_command_not_found_handle_map_res[*]} | sort); do
        echo "  $i:|${autokube_command_not_found_handle_map_res[$i]}"
      done | $tab
      echo
    fi

    if [ -z "$1" ] || [ "${1:0:1}" == o ]; then
      echo Options
      echo -------
      for i in $(printf "%s\n" ${!autokube_command_not_found_handle_map_opt[*]} | sort); do
        echo "  $i:|${autokube_command_not_found_handle_map_opt[$i]}"
      done | $tab
      echo
    fi

    if [ -z "$1" ] || [ "${1:0:1}" == w ]; then
      echo Watches
      echo -------
      for i in $(printf "%s\n" ${!autokube_command_not_found_handle_map_watch[*]} | sort); do
        echo "  $i:|${autokube_command_not_found_handle_map_watch[$i]}"
      done | $tab
      echo
    fi

    echo Please refer to https://github.com/caruccio/autokube for instructions.
  fi

  return 1
}

function kubectl()
{
  echo "\033[36m+ kubectl $@\033[0m" >&2
  command kubectl "$@"
}

command_not_found_handle()
{
  # only search for the command if we're interactive
  [[ $- == *"i"* ]] || return 127

  # don't run if bash command completion is being run
  [[ -n ${COMP_CWORD-} ]] && return 127

  if [ "${1:0:1}" == k ]; then
    local k=${1:1} ## use input
    local p=()     ## kubectl parameters
    local pre=()   ## prepend command
    local f=0      ## number of printf FMT specifiers
    local verb=false
    local res=false

    while [ ${#k} -gt 0 ]; do
      local s=0

      for i in 7 {5..1}; do
        local c=${k:0:$i} ## command
        local cp=''

        if ! $verb; then
          local cp="${autokube_command_not_found_handle_map_verb[$c]}"  ## command parameter
          [ -n "$cp" ] && verb=true
          case "$cp" in
            HELP|FLUSH)
              shift
              autokubectl $cp $@
              return $?
          esac
        fi

        if [ -z "$cp" ] && ! $res; then
          local cp="${autokube_command_not_found_handle_map_res[$c]}"  ## command parameter
          [ -n "$cp" ] && res=true
        fi

        if [ -z "$cp" ]; then
          local cp="${autokube_command_not_found_handle_map_opt[$c]}"  ## command parameter
        fi

        if [ -n "$cp" ]; then
          p+=($cp)
          let s=$i
          [[ "$cp" == *'%'* ]] && let f+=1
          break
        elif [ -n "${autokube_command_not_found_handle_map_watch[$c]}" ]; then
          let s=${#c}
          local wnk=${k:$s}
          local wn=${wnk%%[a-zA-Z]*}
          pre+=( $(printf "${autokube_command_not_found_handle_map_watch[$c]}" ${wn:-2}) )
          local wnl=${#wn}
          [ $wnl -gt 0 ] && let s+=${wnl}
          break
        fi
      done

      if [ $s -eq 0 ]; then
        break
      fi

      k=${k:$s}
    done

    if [ ${#k} -eq 0 ]; then
      shift
      local fv=()
      while [ $f -gt 0 ]; do
        fv+=($1) ## format values
        let f-=1
        shift
      done
      printf -v _cmd "${pre:+${pre[*]} }kubectl ${p[*]}" ${fv[@]}
      if ${AUTOKUBECTL_DRYRUN:-false}; then
        echo "$_cmd $@"
        return 0
      else
        eval "$_cmd $@"
        return $?
      fi
    fi
  fi

  if [[ -n "${BASH_VERSION-}" ]]; then
    printf 'bash: %s%s\n' "${1:+$1: }" "command not found" >&2
  fi

  return 127
}
