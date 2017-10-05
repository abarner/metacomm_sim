
## using the 'MCSIM' package to generate metacommunities
# working from the Sokol et al. 2016 tutorial
# here: http://www.oikosjournal.org/sites/oikosjournal.org/files/appendix/oik-03690.pdf


#### install package ####
devtools::install_github(repo = "sokole/MCSim")

## load
library(MCSim)

#### make a 'landscape' ####

# first get coordinates
n <- 5 # number of sites on landscape
max_coord_x <- 5 # maximum coordinates in x plane
max_coord_y <- 5 # maximum coordinates in y plane

xy_coord <- data.frame(
  x = sample(1:max_coord_x, n),
  y = sample(1:max_coord_y, n)
)

# specify metacommunity size (immigration rate parameter)
m <- 0.5
# specify number of individuals that live in metacom
JM <- 1000000
# specify area of each site
area_m2 <- c()
# specify total number of individuals at each site (alt to JM)
JL <- c()
# specify habitat scores for each site
Ef
# specify the specificity values for environmental filters at each site
# if 0 (default) habitat is a single point on env. gradient. If > 0, site
# habitat is modeled as a normal curve on an environmental gradient
Ef_specificity

# create landscape in MCSim
my_landscape <- fn.make.landscape(
  site.coords = xy_coord,
  m = m,
  JM = JM,
  # area.m2 = c(1, 2, 3, 4, 5) 
)
# returns site coords, distance matrix, extra information ('list of stuff')
# and site info
# - id, area
# - number of individuals in each community

#### run a simulation ####

## for three species...
# set niche positions 
niche_positions <- c(-0.5, 0, 0.5)

# set niche breadths
niche_breadth <- c(0.2, 0.2, 0.5)

# set relative regional (starting) abundances
gamma_abund <- c(0.8, 0.1, 0.1)

# set the probability that a new species appears via recruitment
nu <- 0.001

# how do species move among sites (slope of dispersal kernal)
# same for all species?
W_r <- 0
# vector of dispersal traits
trait_dispersal <- c()
# or set range of dispersal values given to species if traits randomly assigned
trait_dispersal_range <- c()

# set limit to certain things:
# number of new species (speciation.limit =)
# number of individuals (JM.limit =)

# seed regional source pool with Fisher's alpha (alpha.fisher = )

# set timesteps (generations)
timestep <- 10

# run simulation
sim_result <- fn.metaSIM(
  landscape = my_landscape,
  trait.EF = niche_positions,
  trait.Ef.sd = niche_breadth,
  gamma.abund = gamma_abund,
  W.r = W_r,
  nu = nu,
  n.timestep = timestep,
  sim.ID = "my_test_sim",
  output.dir.path = "my_sim_output_dir"
)

library(vegan)
d_pcnm <- data.frame(scores(pcnm(dist(data.frame(x=1:n,y=1)))))

