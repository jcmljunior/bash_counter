#!/usr/bin/env bash

function decrementCounter() {
    echo "Decrementando..."
    counter=$(("$1" - 1))
}
