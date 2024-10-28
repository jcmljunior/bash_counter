#!/usr/bin/env bash

# Exemplo de contador com ações para incrementar e decrementar.
# Author: Julio Cesar <jcmljunior@gmail.com>

function decrementCounter() {
    assert "[[ \$counter -gt 0 ]]" "O contador não pode ser negativo." || return
    ((counter--))
}
