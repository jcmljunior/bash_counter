#!/usr/bin/env bash

# Exemplo de contador com ações para incrementar e decrementar.
# Author: Julio Cesar <jcmljunior@gmail.com>

# Ajustes de formatação.
# Referencias:
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
declare -- reset="\033[0m"
declare -- black="\033[0;30m"
declare -- red="\033[0;31m"
declare -- green="\033[0;32m"
declare -- yellow="\033[0;33m"
declare -- blue="\033[0;34m"
declare -- purple="\033[0;35m"
declare -- cyan="\033[0;36m"
declare -- white="\033[0;37m"

# Texto com cores em negrito.
declare -- bblack="\033[1;30m"
declare -- bred="\033[1;31m"
declare -- bgreen="\033[1;32m"
declare -- byellow="\033[1;33m"
declare -- bblue="\033[1;34m"
declare -- bpurple="\033[1;35m"
declare -- bcyan="\033[1;36m"
declare -- bwhite="\033[1;37m"

# Texto com cores sublinhado.
declare -- UBlack="\033[4;30m"
declare -- URed="\033[4;31m"
declare -- UGreen="\033[4;32m"
declare -- UYellow="\033[4;33m"
declare -- UBlue="\033[4;34m"
declare -- UPurple="\033[4;35m"
declare -- UCyan="\033[4;36m"
declare -- UWhite="\033[4;37m"

# Cor de fundo
declare -- onBlack="\033[40m"
declare -- onRed="\033[41m"
declare -- onGreen="\033[42m"
declare -- onYellow="\033[43m"
declare -- onBlue="\033[44m"
declare -- onPurple="\033[45m"
declare -- onCyan="\033[46m"
declare -- onWhite="\033[47m"

function clear() {
    printf "\033c"
}

function get_path() {
    cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd
}

function assert() {
    if ! eval "$1"; then
        echo "Assertion failed: $2"
        exit "$1"
    fi
}

function ready() {
    clear

    echo ""
    echo -e "[Contador: $yellow$counter$reset]"
    echo ""
}

function process() {
    echo -e "${bwhite}Selecione a ação para continuar.${reset}"

    create_main_menu
}

function create_main_menu() {
    for str in "${menuItems[@]}"; do
        if [ "${menuItems[$menuCurrentPosition]}" == "$str" ]; then
            echo -e "[ ${yellow}*${reset} ] $UWhite$str$reset"
            continue
        fi

        echo "[   ] $str"
    done
}

# Referencias:
# https://diegomariano.com/shell-script-um-guia-basico/
function handle_menu_navigation() {
    if [ "$response" == "A" ]; then
        move_menu_position_up
    fi

    if [ "$response" == "B" ]; then
        move_menu_position_down
    fi
}

function move_menu_position_up() {
    [[ "$menuCurrentPosition" -gt 0 ]] && menuCurrentPosition=$(("$menuCurrentPosition" - 1))
}

function move_menu_position_down() {
    [[ "$menuCurrentPosition" -lt "${#menuItems[@]}" ]] && menuCurrentPosition=$(("$menuCurrentPosition" + 1))
}

function get_input() {
    # Captura a primeira tecla pressionada pelo utilizador e atribui a 'response'.
    read -s -r -n1 response

    handle_menu_navigation "$response"

    if [ -z "$response" ]; then
        case "${menuItems[$menuCurrentPosition]}" in
        "${menuItems[0]}")
            incrementCounter "$counter"
            ;;

        "${menuItems[1]}")
            decrementCounter "$counter"
            ;;

        "${menuItems[2]}")
            isProcess="false"
            ;;
        esac
    fi
}

function main() {
    declare -I basePath="$(get_path)"
    declare -I isProcess="true"
    declare -I counter=0

    declare -Ia menuCurrentPosition=0
    declare -Ia menuItems=(
        "Incrementar contador"
        "Decrementar contador"
        "Sair"
    )

    # Importação das funcionalidades.
    source "${basePath}/actions/increment_counter.bash"
    source "${basePath}/actions/decrement_counter.bash"

    while "$isProcess"; do
        ready

        while true; do
            process
            get_input
            break
        done
    done
}

main
