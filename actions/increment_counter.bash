#!/usr/bin/env bash

# Exemplo de contador com ações para incrementar e decrementar.
# Author: Julio Cesar <jcmljunior@gmail.com>

function incrementCounter() {
    assert  "[[ \$counter -lt 10 ]]" "Contador ultrapassou o limite de 10."
    ((counter++))
}
