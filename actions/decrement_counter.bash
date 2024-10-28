#!/usr/bin/env bash

# Exemplo de contador com ações para incrementar e decrementar.
# Author: Julio Cesar <jcmljunior@gmail.com>

function decrementCounter() {
    counter=$(("$1" - 1))
}
