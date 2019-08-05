# Hello
# Here you are going to learn how to create a Sankey Diagram with the networkD3 library.

# In my example, the Sankey Diagram will show a timeline of some of Vincent Van Gogh's paintings.

# You are listening: Solitude - Sakamoto Ryuichi.
# I chose this composition because I think it reflects Van Gogh's fragile soul.

# You need to install the following package: install.packages('networkD3')
library(networkD3)

# networkdD3: https://cran.r-project.org/web/packages/networkD3/networkD3.pdf

# Let's list some of Van Gogh's paintings in a dataframe:
nodes = data.frame("Vincent" = 
                     c("1853: Vincent is born", # Node 0
                       "1881: Crouching Boy with Sickle", # Node 1
                       "1882: Woman with White Shawl", # Node 2
                       "1883: Peasant Burning Weeds", # Node 3
                       "1884: Winter Garden", # Node 4
                       "1885: The potato Eaters", # Node 5
                       "1886: Self-Portrait", # Node 6
                       "1888: Café Terrace At Night", # Node 7
                       "1888: Sunflowers",# Node 8
                       "1889: The Bedroom", # Node 9
                       "1889: Self-Portrait with Bandaged Ear",# Node 10
                       "1889: Starry Night", # Node 11
                       "1890: Wheatfield With Crows", # Node 12
                       "1890: Almond Blossoms", # Node 13
                       "1890: Tree Roots (Last Van Gogh's Painting)" # Node 14
                       ))
nodes # the (rows - 1) corresponde to the nodes

# Here we create our node connections
links = as.data.frame(matrix(c(
  0, 1, 1, #here: "1853: Vincent is born" --> "1881: Crouching Boy with Sickle"
  0, 2, 1,
  0, 3, 1,
  0, 4, 1,
  0, 6, 1,
  1, 5, 1,
  2, 5, 1,
  3, 5, 1, 
  4, 5, 1, 
  6, 5, 1,
  5, 7, 1,
  5, 8, 1,
  5, 9, 1,
  5, 10, 1,
  9, 13, 1,
  10, 13, 1,
  7,11,1,
  8,11,1,
  11, 12, 1,
  12,14,1,
  13,12,1),
  byrow = TRUE, ncol = 3))

names(links) = c("source", "target", "value")
links
# Each row represents a link. 
# The first number represents the node being conntected from. 
# The second number represents the node connected to.
# The third number is the value of the node (in this example, all equals to 1).

# Here is where we create our Sankey
# define the colourScale
colourScale = JS("d3.scaleOrdinal(d3.schemeCategory20);")

sankeyNetwork(Links = links, Nodes = nodes,
              Source = "source", Target = "target",
              Value = "value", NodeID = "Vincent",
              fontSize= 8, nodeWidth = 10, nodePadding = 140,
              colourScale = colourScale)

# I now try to make it a bit nicer

# A Sankey diagram is a flow diagram generally used to depict a flow from one set of values to another.
# The things being connected are called nodes
# (in our examples the nodes are the paintings) and the connections are called links.
# A real-world example: Google Analytics uses sankeys to show
# how traffic flows from pages to other pages on your web site.

# Thanks For Watching
print("If you liked the video, please subscribe to the channel") 
# https://www.youtube.com/channel/UCokk3F3UoS7O0Vmja7MXi-w
print("and like the facebook page Jabraghe:Learn with Classical Music")
# https://www.facebook.com/Jabraghe/