setwd("~/pub/slides/rmeetup_oct2015")

# get commands ------------------------------
hello='echo Hello World !'

sleep=c('sleep 5', 'sleep 5')

tmp=c('cat $RANDOM > tmp1', 
			'cat $RANDOM > tmp2')
			
merge='cat tmp1 tmp2 > tmp'
			
size='du -sh tmp'


# create flowmat ------------------------------
library(flowr)
## create a named list 
lst = list(hello=hello, sleep=sleep, tmp=tmp, merge=merge, size=size)

flowmat = to_flowmat(lst, "samp1")

cat(kable(flowmat), file = "flowmat.tsv", sep = "\n")


# create a flowdef ------------------------------
flowdef = to_flowdef(flowmat)
kable(flowdef[, c(1:4, 8)])
write_sheet(flowdef, "flowdef.tsv")

plot_flow(flowdef)
plot_flow(flowdef, pdffile = "example_default.pdf")


# customize a flowdef ------------------------------
flowdef = to_flowdef(flowmat,
										 sub_type = c("serial", "scatter", "scatter", "serial", "serial"),
										 dep_type = c("none", "burst", "serial", "gather", "serial"), 
										 platform = "local")
plot_flow(flowdef)
plot_flow(flowdef, pdffile = "example_custom.pdf")

# submit to a cluster ------------------------------
fobj = to_flow(flowmat, flowdef, execute = TRUE)