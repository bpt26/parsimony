args = commandArgs(trailingOnly=TRUE)

library(ape)

input.tree.filename = args[1]
output.tree.filename = args[2]

input.tree = read.tree(input.tree.filename)

input.tree$edge.length = ifelse(is.na(input.tree$edge.length), 0, input.tree$edge.length)

output.tree = multi2di(input.tree)

output.tree = unroot(output.tree)

write.tree(output.tree, output.tree.filename)
