args = commandArgs(trailingOnly=TRUE)

library(ape)

input.tree.filename = args[1]
output.tree.filename = args[2]

input.tree = read.tree(input.tree.filename)

input.tree$edge.length = ifelse(is.na(input.tree$edge.length), 0, input.tree$edge.length)

output.tree = multi2di(input.tree)

output.tree = unroot(output.tree)

# thanks to David Winter on Twitter, but also others: https://twitter.com/RobLanfear/status/1389392629431869440
output.tree = collapse.singles(output.tree)

write.tree(output.tree, output.tree.filename)
