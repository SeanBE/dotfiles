#!/bin/bash

# TODO move to ansible playbook.

# install rust
curl https://sh.rustup.rs -sSf | sh

# install rustfmt
cargo install rustfmt

# install racer
cargo install racer

# get rust sources for racer
rustup component add rust-src
